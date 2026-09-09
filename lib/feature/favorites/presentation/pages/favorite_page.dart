import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/products_strings.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../products/presentation/cubit/product_cubit.dart';
import '../../../products/presentation/widgets/product_grid.dart';
import '../cubit/favorite_cubit.dart';
import '../cubit/favorite_state.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ProductStrings.favorites)),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          final allProducts = context.read<ProductCubit>().allProducts;

          final favoriteProducts = allProducts
              .where((product) => state.favoriteIds.contains(product.id))
              .toList();

          if (favoriteProducts.isEmpty) {
            return AppEmptyState(message: ProductStrings.noFavorites);
          }

          return SingleChildScrollView(
            child: ProductGrid(products: favoriteProducts, enableHero: false),
          );
        },
      ),
    );
  }
}
