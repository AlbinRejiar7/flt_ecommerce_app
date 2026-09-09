import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/exceptions.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

import '../filter_data/product_filter_options.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;
  static const int pageSize = 8;
  int _visibleCount = pageSize;

  List<ProductModel> _allProducts = [];

  String _searchQuery = '';
  ProductFilterOption? _selectedFilter;

  ProductCubit(this.repository) : super(const ProductInitial());

  List<ProductModel> get allProducts => List.unmodifiable(_allProducts);

  Future<void> fetchProducts({bool refresh = false}) async {
    if (!refresh) {
      emit(const ProductLoading());
    }

    try {
      final products = await repository.getProducts();

      _allProducts = products;
      _visibleCount = pageSize;
      if (!refresh) {
        _searchQuery = '';
        _selectedFilter = null;
      }

      _applyFilters();
    } on AppException catch (e) {
      emit(ProductError(e.message));
    } catch (_) {
      emit(const ProductError('Something went wrong'));
    }
  }

  void filterProducts(ProductFilterOption? filter) {
    _visibleCount = pageSize;
    _selectedFilter = filter;
    _applyFilters();
  }

  void searchProducts(String query) {
    _visibleCount = pageSize;
    _searchQuery = query.trim().toLowerCase();

    _applyFilters();
  }

  void loadMore() {
    final currentState = state;
    if (currentState is! ProductLoaded || !currentState.hasMore) return;

    _visibleCount += pageSize;
    _applyFilters();
  }

  void _applyFilters() {
    Iterable<ProductModel> products = _allProducts;

    if (_selectedFilter != null) {
      final selectedCategory = _selectedFilter!.category?.toLowerCase();

      products = products.where((product) {
        final productCategory = product.category.toLowerCase();

        if (selectedCategory == 'clothing') {
          return productCategory.contains('clothing');
        }

        return productCategory == selectedCategory;
      });
    }

    if (_searchQuery.isNotEmpty) {
      products = products.where((product) {
        return product.title.toLowerCase().contains(_searchQuery);
      });
    }

    final matchingProducts = products.toList();
    emit(
      ProductLoaded(
        products: matchingProducts.take(_visibleCount).toList(),
        selectedFilter: _selectedFilter,
        hasMore: matchingProducts.length > _visibleCount,
      ),
    );
  }
}
