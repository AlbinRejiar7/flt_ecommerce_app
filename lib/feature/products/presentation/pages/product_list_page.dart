import 'package:flt_ecommerce_app/core/constants/app_breakpoints.dart';
import 'package:flt_ecommerce_app/core/constants/app_spacing.dart';
import 'package:flt_ecommerce_app/core/constants/products_strings.dart';
import 'package:flt_ecommerce_app/core/widgets/app_empty_state.dart';
import 'package:flt_ecommerce_app/feature/products/presentation/widgets/category_selector.dart';
import 'package:flt_ecommerce_app/feature/products/presentation/widgets/most_popular_header.dart';
import 'package:flt_ecommerce_app/feature/products/presentation/widgets/product_filter_tabs.dart';
import 'package:flt_ecommerce_app/feature/products/presentation/widgets/product_grid.dart';
import 'package:flt_ecommerce_app/feature/products/presentation/widgets/product_list_header.dart';
import 'package:flt_ecommerce_app/feature/products/presentation/widgets/product_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import '../widgets/special_offer_carousel.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage>
    with WidgetsBindingObserver {
  final FocusNode _searchFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  bool _paginationCheckScheduled = false;

  bool _isSearching = false;
  bool _keyboardWasVisible = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _searchFocusNode.addListener(_onSearchFocusChanged);
    _scrollController.addListener(_schedulePaginationCheck);
  }

  void _schedulePaginationCheck() {
    if (_paginationCheckScheduled) return;
    _paginationCheckScheduled = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _paginationCheckScheduled = false;
      if (!mounted || !_scrollController.hasClients) return;

      final position = _scrollController.position;
      if (position.hasContentDimensions && position.extentAfter <= 300) {
        context.read<ProductCubit>().loadMore();
      }
    });
  }

  void _onSearchFocusChanged() {
    if (_searchFocusNode.hasFocus && !_isSearching) {
      setState(() {
        _isSearching = true;
      });
    }

    if (!_searchFocusNode.hasFocus && _isSearching) {
      setState(() {
        _isSearching = false;
      });
    }
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final keyboardHeight = View.of(context).viewInsets.bottom;
      final keyboardVisible = keyboardHeight > 0;

      if (keyboardVisible) {
        _keyboardWasVisible = true;
        return;
      }

      if (_keyboardWasVisible && !keyboardVisible) {
        _keyboardWasVisible = false;
        _searchFocusNode.unfocus();

        if (_isSearching) {
          setState(() {
            _isSearching = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _searchFocusNode.removeListener(_onSearchFocusChanged);
    _searchFocusNode.dispose();
    _scrollController.removeListener(_schedulePaginationCheck);
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductInitial) {
              return const SizedBox.shrink();
            }

            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductLoaded) {
              // Also fill tall viewports where the first page cannot scroll.
              if (state.hasMore) _schedulePaginationCheck();
              return RefreshIndicator(
                onRefresh: () =>
                    context.read<ProductCubit>().fetchProducts(refresh: true),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ProductListHeader(),

                      AnimatedPadding(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutCubic,
                        padding: EdgeInsets.only(
                          top: _isSearching ? AppSpacing.sm : 0,
                        ),
                        child: ProductSearchBar(focusNode: _searchFocusNode),
                      ),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        reverseDuration: const Duration(milliseconds: 250),
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SizeTransition(
                                  sizeFactor: animation,
                                  axisAlignment: -1,
                                  child: child,
                                ),
                              );
                            },
                        child: _isSearching
                            ? const SizedBox.shrink(
                                key: ValueKey('search-content'),
                              )
                            : Column(
                                key: const ValueKey('normal-content'),
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      final isTablet =
                                          constraints.maxWidth >=
                                          AppBreakpoints.mobile;

                                      if (isTablet) {
                                        return const Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: SpecialOffersSection(),
                                            ),
                                            Expanded(child: CategorySelector()),
                                          ],
                                        );
                                      }

                                      return const Column(
                                        children: [
                                          SpecialOffersSection(),
                                          SizedBox(height: AppSpacing.lg),
                                          CategorySelector(),
                                        ],
                                      );
                                    },
                                  ),
                                  const MostPopularHeader(),
                                ],
                              ),
                      ),

                      AnimatedPadding(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        padding: EdgeInsets.only(
                          top: _isSearching ? AppSpacing.md : 0,
                        ),
                        child: ProductFilterTabs(
                          selectedFilter: state.selectedFilter,
                          onSelected: (filter) {
                            context.read<ProductCubit>().filterProducts(filter);
                          },
                        ),
                      ),

                      const SizedBox(height: AppSpacing.lg),

                      if (state.products.isEmpty)
                        Center(
                          child: AppEmptyState(
                            message: ProductStrings.noProducts,
                          ),
                        )
                      else
                        ProductGrid(products: state.products, enableHero: true),
                    ],
                  ),
                ),
              );
            }

            if (state is ProductError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message, textAlign: TextAlign.center),
                    const SizedBox(height: AppSpacing.md),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProductCubit>().fetchProducts();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
