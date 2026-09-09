import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/app_icons.dart';
import '../cubit/product_cubit.dart';

class ProductSearchBar extends StatelessWidget {
  final FocusNode focusNode;

  const ProductSearchBar({super.key, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: TextField(
        focusNode: focusNode,
        textInputAction: TextInputAction.search,
        onChanged: (value) {
          context.read<ProductCubit>().searchProducts(value);
        },
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: AppDimensions.searchBarIconArea,
            minHeight: AppDimensions.searchBarIconArea,
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: AppDimensions.searchBarIconArea,
            minHeight: AppDimensions.searchBarIconArea,
          ),
          prefixIcon: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: MyAppIcons(
              iconData: AppIcons.search,
              size: AppDimensions.searchBarIconSize,
              color: colors.onSurfaceVariant,
            ),
          ),
          suffixIcon: Center(
            widthFactor: 1,
            heightFactor: 1,
            child: MyAppIcons(
              iconData: AppIcons.filter,
              size: AppDimensions.searchBarIconSize,
              color: colors.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
