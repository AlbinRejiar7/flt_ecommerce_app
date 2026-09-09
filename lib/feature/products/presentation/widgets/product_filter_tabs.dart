import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/app_spacing.dart';
import '../filter_data/product_filter_options.dart';

class ProductFilterTabs extends StatelessWidget {
  final ProductFilterOption? selectedFilter;
  final ValueChanged<ProductFilterOption?> onSelected;

  const ProductFilterTabs({
    super.key,
    required this.selectedFilter,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filters = ProductFilterOptions.items;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: _FilterChip(
              label: 'All',
              isSelected: selectedFilter == null,
              onTap: () {
                onSelected(null);
              },
            ),
          ),

          ...filters.map((filter) {
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: _FilterChip(
                label: filter.label,
                isSelected: selectedFilter == filter,
                onTap: () {
                  onSelected(filter);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return FilterChip(
      label: Text(label),

      selected: isSelected,
      showCheckmark: false,

      selectedColor: colors.inverseSurface,
      backgroundColor: colors.surface,

      side: BorderSide(
        color: colors.onSurface,
        width: AppDimensions.borderWidth,
      ),

      shape: const StadiumBorder(),

      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

      visualDensity: VisualDensity.compact,

      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),

      labelPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),

      labelStyle: theme.textTheme.bodyMedium?.copyWith(
        color: isSelected ? colors.onInverseSurface : colors.onSurface,
        fontWeight: FontWeight.w600,
      ),

      onSelected: (_) {
        onTap();
      },
    );
  }
}
