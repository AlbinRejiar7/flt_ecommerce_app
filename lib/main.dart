import 'package:flt_ecommerce_app/feature/favorites/presentation/cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'core/network/api_client.dart';
import 'feature/cart/presentation/cubit/cart_cubit.dart';
import 'feature/products/data/datasources/product_remote_data_source.dart';
import 'feature/products/data/repositories/product_repository.dart';
import 'feature/products/presentation/cubit/product_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final apiClient = ApiClient();

  final remoteDataSource = ProductRemoteDataSource(apiClient.dio);

  final repository = ProductRepository(remoteDataSource);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductCubit(repository)..fetchProducts()),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => FavoriteCubit()..loadFavorites()),
      ],
      child: const App(),
    ),
  );
}
