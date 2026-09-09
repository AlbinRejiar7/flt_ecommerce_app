import 'package:flt_ecommerce_app/core/constants/products_strings.dart';
import 'package:flt_ecommerce_app/core/widgets/app_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_spacing.dart';

import '../../../products/presentation/widgets/app_primary_button.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../widgets/cart_item_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const AppEmptyState(message: ProductStrings.emptyCart);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Text(
                  'My Cart',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              Expanded(
                child: ListView.separated(
                  itemCount: state.items.length,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: (context, index) {
                    return CartItemCard(item: state.items[index]);
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Total', style: theme.textTheme.titleLarge),
                        const Spacer(),
                        Text(
                          '\$${state.totalPrice.toStringAsFixed(2)}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    AppPrimaryButton(text: 'Checkout', onPressed: () {}),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
