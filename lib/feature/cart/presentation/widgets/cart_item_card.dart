import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../data/models/cart_item.dart';
import '../cubit/cart_cubit.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: AppDimensions.cartProductImageSize,
            height: AppDimensions.cartProductImageSize,
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.productImageBackground,
              borderRadius: BorderRadius.circular(AppRadius.large),
            ),
            child: AppNetworkImage(
              imageUrl: item.product.image,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.title,
                  maxLines: AppDimensions.singleLine,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: AppSpacing.sm),

                Text(
                  '\$${item.product.price.toStringAsFixed(2)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: AppSpacing.sm),

                Row(
                  children: [
                    IconButton(
                      onPressed: item.quantity > 1
                          ? () {
                              context.read<CartCubit>().decreaseQuantity(
                                item.product.id,
                              );
                            }
                          : null,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),

                    Text(
                      item.quantity.toString(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        context.read<CartCubit>().increaseQuantity(
                          item.product.id,
                        );
                      },
                      icon: const Icon(Icons.add_circle_outline),
                    ),

                    const Spacer(),

                    IconButton(
                      onPressed: () {
                        context.read<CartCubit>().removeFromCart(
                          item.product.id,
                        );
                      },
                      color: colors.error,
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
