import 'package:flutter/material.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/app_icons.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  static const categories = <_CategoryItem>[
    _CategoryItem(title: 'Clothes', icon: AppIcons.clothes),
    _CategoryItem(title: 'Shoes', icon: AppIcons.shoes),
    _CategoryItem(title: 'Bags', icon: AppIcons.bags),
    _CategoryItem(title: 'Electronics', icon: AppIcons.electronics),
    _CategoryItem(title: 'Watch', icon: AppIcons.watch),
    _CategoryItem(title: 'Jewelry', icon: AppIcons.jewelry),
    _CategoryItem(title: 'Kitchen', icon: AppIcons.kitchen),
    _CategoryItem(title: 'More', icon: AppIcons.more),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppDimensions.categoryColumnCount,
        mainAxisExtent: AppDimensions.categoryItemHeight,
        mainAxisSpacing: AppSpacing.lg,
        crossAxisSpacing: AppSpacing.md,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: AppDimensions.categoryAvatarRadius,
              backgroundColor: colors.surfaceContainerHighest,
              child: MyAppIcons(
                iconData: category.icon,
                size: AppDimensions.categoryIconSize,
                color: colors.onSurface,
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            Text(
              category.title,
              maxLines: AppDimensions.singleLine,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CategoryItem {
  final String title;
  final List<List> icon;

  const _CategoryItem({required this.title, required this.icon});
}
