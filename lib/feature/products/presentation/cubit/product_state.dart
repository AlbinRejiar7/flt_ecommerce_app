import 'package:equatable/equatable.dart';

import '../../data/models/product_model.dart';
import '../filter_data/product_filter_options.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

final class ProductInitial extends ProductState {
  const ProductInitial();
}

final class ProductLoading extends ProductState {
  const ProductLoading();
}

final class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final ProductFilterOption? selectedFilter;
  final bool hasMore;

  const ProductLoaded({
    required this.products,
    this.selectedFilter,
    this.hasMore = false,
  });

  @override
  List<Object?> get props => [products, selectedFilter, hasMore];
}

final class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
