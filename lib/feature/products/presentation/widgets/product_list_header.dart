import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/products_strings.dart';
import '../../../../core/widgets/app_icons.dart';

class ProductListHeader extends StatelessWidget {
  const ProductListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.lg,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppDimensions.profileAvatarRadius,
            backgroundColor: colors.surfaceContainerHighest,
            child: MyAppIcons(
              iconData: AppIcons.person,
              size: AppDimensions.headerIconSize,
              color: colors.onSurface,
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ProductStrings.greeting, style: theme.textTheme.bodySmall),

                const SizedBox(height: AppSpacing.xs),

                Text(
                  ProductStrings.userName,
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: MyAppIcons(
              iconData: AppIcons.notification,
              size: AppDimensions.headerIconSize,
              color: colors.onSurface,
            ),
          ),

          IconButton(
            onPressed: () {
              context.pushNamed('favorites');
            },
            icon: MyAppIcons(
              iconData: AppIcons.favorite,
              size: AppDimensions.headerIconSize,
              color: colors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
