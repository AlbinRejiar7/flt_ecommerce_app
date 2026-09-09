import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepository(this.remoteDataSource);

  Future<List<ProductModel>> getProducts() async {
    return await remoteDataSource.getProducts();
  }
}
