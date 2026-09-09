import 'package:flt_ecommerce_app/feature/favorites/presentation/cubit/favorite_cubit.dart';
import 'package:flt_ecommerce_app/feature/favorites/presentation/cubit/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/app_icons.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final bool enableHero;

  const ProductCard({
    super.key,
    required this.product,
    required this.enableHero,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final productImage = Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.productImageBackground,
          borderRadius: BorderRadius.circular(AppRadius.extraLarge),
        ),
        child: AppNetworkImage(imageUrl: product.image, fit: BoxFit.contain),
      ),
    );

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.extraLarge),
      onTap: () {
        context.pushNamed('product-detail', extra: product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                enableHero
                    ? Hero(
                        tag: 'product-image-${product.id}',
                        child: productImage,
                      )
                    : productImage,

                Positioned(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
                  child: BlocBuilder<FavoriteCubit, FavoriteState>(
                    builder: (context, state) {
                      final isFavorite = state.isFavorite(product.id);

                      return InkWell(
                        onTap: () {
                          context.read<FavoriteCubit>().toggleFavorite(
                            product.id,
                          );
                        },
                        borderRadius: BorderRadius.circular(
                          AppRadius.extraLarge,
                        ),
                        child: Container(
                          width: AppDimensions.favoriteButtonSize,
                          height: AppDimensions.favoriteButtonSize,
                          decoration: BoxDecoration(
                            color: colors.inverseSurface,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            size: AppDimensions.favoriteIconSize,
                            color: colors.onInverseSurface,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          Text(
            product.title,
            maxLines: AppDimensions.singleLine,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: AppSpacing.xs),

          if (product.rating != null)
            Row(
              children: [
                MyMaterialIcon(
                  iconData: AppIcons.halfStar,
                  size: AppDimensions.ratingIconSize,
                  color: colors.onSurface,
                ),

                const SizedBox(width: AppSpacing.xs),

                Text(
                  product.rating!.rate.toStringAsFixed(1),
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(
                  height: AppDimensions.ratingDividerHeight,
                  child: VerticalDivider(
                    width: AppSpacing.lg,
                    thickness: AppDimensions.dividerWidth,
                    color: colors.outlineVariant,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppRadius.extraSmall),
                  ),
                  child: Text(
                    '${product.rating!.count} sold',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),

          const SizedBox(height: AppSpacing.sm),

          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
