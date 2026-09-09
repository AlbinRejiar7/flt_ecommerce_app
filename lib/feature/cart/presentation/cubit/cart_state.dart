import 'package:equatable/equatable.dart';

import '../../data/models/cart_item.dart';

sealed class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  int get totalItems {
    return items.fold(0, (total, item) => total + item.quantity);
  }

  double get totalPrice {
    return items.fold(0, (total, item) => total + item.totalPrice);
  }

  @override
  List<Object?> get props => [items];
}

final class CartInitial extends CartState {
  const CartInitial();
}

final class CartLoaded extends CartState {
  const CartLoaded({required super.items});
}

final class CartError extends CartState {
  final String message;

  const CartError({required this.message, required super.items});

  @override
  List<Object?> get props => [...super.props, message];
}
