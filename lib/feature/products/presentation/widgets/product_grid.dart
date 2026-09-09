import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../data/models/product_model.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductModel> products;
  final bool enableHero;
  const ProductGrid({
    super.key,
    required this.products,
    required this.enableHero,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.sm,
            AppSpacing.xl,
            AppSpacing.xxl,
          ),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: AppDimensions.tabletCardMaxWidth,
            crossAxisSpacing: AppSpacing.lg,
            mainAxisSpacing: AppSpacing.xl,
            childAspectRatio: AppDimensions.mobileCardAspectRatio,
          ),
          itemBuilder: (context, index) {
            return ProductCard(
              product: products[index],
              enableHero: enableHero,
            );
          },
        );
      },
    );
  }
}
