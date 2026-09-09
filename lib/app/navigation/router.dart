import 'package:flt_ecommerce_app/app/navigation/app_page_transition.dart';
import 'package:flt_ecommerce_app/feature/favorites/presentation/pages/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../feature/products/data/models/product_model.dart';

import '../../feature/products/presentation/pages/product_detail_page.dart';
import '../navigation/main_navigation_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) {
        return const MainNavigationPage();
      },
    ),
    GoRoute(
      path: '/product-detail',
      name: 'product-detail',
      pageBuilder: (context, state) {
        final product = state.extra;

        if (product is! ProductModel) {
          return MaterialPage(
            key: state.pageKey,
            child: Scaffold(
              appBar: AppBar(title: const Text('Product details')),
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Product unavailable. Please select a product from Home.',
                    ),
                    TextButton(
                      onPressed: () => context.goNamed('home'),
                      child: const Text('Back to Home'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return MaterialPage(
          key: state.pageKey,
          child: ProductDetailPage(product: product),
        );
      },
    ),
    GoRoute(
      path: '/favorites',
      name: 'favorites',
      pageBuilder: (context, state) {
        return appTransition(state: state, child: const FavoritePage());
      },
    ),
  ],
);
