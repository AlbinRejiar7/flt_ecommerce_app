import 'package:flt_ecommerce_app/core/constants/app_colors.dart';
import 'package:flt_ecommerce_app/core/constants/products_strings.dart';
import 'package:flt_ecommerce_app/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../data/models/product_model.dart';
import '../widgets/app_primary_button.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text(ProductStrings.productDetails)),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.xl,
          AppSpacing.xl,
          AppSpacing.xxl + AppSpacing.xxl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppDimensions.productDetailImageHeight,
              width: double.infinity,
              child: Hero(
                tag: 'product-image-${product.id}',
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.productImageBackground,
                      borderRadius: BorderRadius.circular(AppRadius.extraLarge),
                    ),
                    child: AppNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            Text(
              product.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            Row(
              children: [
                const Icon(
                  Icons.star,
                  size: AppDimensions.productDetailRatingIconSize,
                ),

                const SizedBox(width: AppSpacing.xs),

                Text(product.rating?.rate.toStringAsFixed(1) ?? '0.0'),

                const SizedBox(width: AppSpacing.sm),

                Text(
                  '(${product.rating?.count ?? 0})',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.lg),

            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            Text(
              ProductStrings.description,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            Text(product.description, style: theme.textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.xxxxl),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: SizedBox(
          width: double.infinity,
          child: AppPrimaryButton(
            text: ProductStrings.addToCart,
            onPressed: () {
              final added = context.read<CartCubit>().addToCart(product);

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      added
                          ? ProductStrings.addedToCart
                          : ProductStrings.alreadyInCart,
                    ),
                  ),
                );
            },
          ),
        ),
      ),
    );
  }
}
