import 'package:dio/dio.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

class ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSource(this.dio);

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get(AppConstants.productsEndpoint);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is! List) {
          throw const DataParsingException();
        }

        return data
            .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      throw const ServerException();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw const RequestTimeoutException();
      }

      if (e.type == DioExceptionType.connectionError) {
        throw const NetworkException();
      }

      throw const ServerException();
    } on FormatException {
      throw const DataParsingException();
    } on AppException {
      rethrow;
    } catch (_) {
      throw const UnknownException();
    }
  }
}
