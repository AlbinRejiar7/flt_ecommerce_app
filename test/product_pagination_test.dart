import 'package:dio/dio.dart';
import 'package:flt_ecommerce_app/feature/products/data/datasources/product_remote_data_source.dart';
import 'package:flt_ecommerce_app/feature/products/data/models/product_model.dart';
import 'package:flt_ecommerce_app/feature/products/data/repositories/product_repository.dart';
import 'package:flt_ecommerce_app/feature/products/presentation/cubit/product_cubit.dart';
import 'package:flt_ecommerce_app/feature/products/presentation/cubit/product_state.dart';
import 'package:flt_ecommerce_app/feature/products/presentation/filter_data/product_filter_options.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeProductRepository extends ProductRepository {
  FakeProductRepository() : super(ProductRemoteDataSource(Dio()));

  int requests = 0;

  @override
  Future<List<ProductModel>> getProducts() async {
    requests++;
    return List.generate(
      19,
      (index) => ProductModel(
        id: index,
        title: 'Product $index',
        price: 10,
        description: 'Description',
        category: index < 10 ? 'electronics' : 'jewelery',
      ),
    );
  }
}

void main() {
  late FakeProductRepository repository;
  late ProductCubit cubit;

  setUp(() {
    repository = FakeProductRepository();
    cubit = ProductCubit(repository);
  });
  tearDown(() => cubit.close());

  test('appends pages without duplicates and stops at the end', () async {
    await cubit.fetchProducts();
    expect((cubit.state as ProductLoaded).products.length, 8);
    expect(cubit.allProducts.length, 19);
    cubit.loadMore();
    expect((cubit.state as ProductLoaded).products.length, 16);
    cubit.loadMore();
    final state = cubit.state as ProductLoaded;
    expect(state.products.map((p) => p.id), List.generate(19, (i) => i));
    expect(state.hasMore, isFalse);
    cubit.loadMore();
    expect(cubit.state, state);
    expect(repository.requests, 1);
  });

  test('filters the full catalog and resets pagination', () async {
    await cubit.fetchProducts();
    cubit.loadMore();
    cubit.filterProducts(
      const ProductFilterOption(label: 'Jewelry', category: 'jewelery'),
    );
    expect((cubit.state as ProductLoaded).products.first.id, 10);
    expect((cubit.state as ProductLoaded).products.length, 8);
    cubit.loadMore();
    expect((cubit.state as ProductLoaded).products.length, 9);
    cubit.searchProducts('Product 18');
    expect((cubit.state as ProductLoaded).products.single.id, 18);
    cubit.searchProducts('missing');
    expect((cubit.state as ProductLoaded).products, isEmpty);
    expect((cubit.state as ProductLoaded).hasMore, isFalse);
  });

  test(
    'refresh fetches again, preserves filters and resets the page',
    () async {
      await cubit.fetchProducts();
      const filter = ProductFilterOption(
        label: 'Electronics',
        category: 'electronics',
      );
      cubit.filterProducts(filter);
      cubit.searchProducts('Product');
      cubit.loadMore();
      expect((cubit.state as ProductLoaded).products.length, 10);
      await cubit.fetchProducts(refresh: true);
      final state = cubit.state as ProductLoaded;
      expect(repository.requests, 2);
      expect(state.selectedFilter, filter);
      expect(state.products.length, 8);
      expect(state.hasMore, isTrue);
    },
  );
}
