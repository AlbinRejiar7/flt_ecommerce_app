import 'package:flt_ecommerce_app/core/constants/products_strings.dart';
import 'package:flt_ecommerce_app/feature/cart/data/models/cart_item.dart';
import 'package:flt_ecommerce_app/feature/products/data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartInitial());

  List<CartItem> _items = [];

  bool addToCart(ProductModel product) {
    try {
      final alreadyExists = _items.any((item) => item.product.id == product.id);

      if (alreadyExists) {
        return false;
      }

      _items = [..._items, CartItem(product: product)];

      emit(CartLoaded(items: List.unmodifiable(_items)));

      return true;
    } catch (_) {
      emit(
        CartError(
          message: ProductStrings.failedToAddToCart,
          items: List.unmodifiable(_items),
        ),
      );

      return false;
    }
  }

  void increaseQuantity(int productId) {
    try {
      _items = _items.map((item) {
        if (item.product.id == productId) {
          return item.copyWith(quantity: item.quantity + 1);
        }

        return item;
      }).toList();

      emit(CartLoaded(items: List.unmodifiable(_items)));
    } catch (_) {
      emit(
        CartError(
          message: ProductStrings.failedToUpdateQuantity,
          items: List.unmodifiable(_items),
        ),
      );
    }
  }

  void decreaseQuantity(int productId) {
    try {
      _items = _items.map((item) {
        if (item.product.id == productId && item.quantity > 1) {
          return item.copyWith(quantity: item.quantity - 1);
        }

        return item;
      }).toList();

      emit(CartLoaded(items: List.unmodifiable(_items)));
    } catch (_) {
      emit(
        CartError(
          message: ProductStrings.failedToUpdateQuantity,
          items: List.unmodifiable(_items),
        ),
      );
    }
  }

  void removeFromCart(int productId) {
    try {
      _items = _items.where((item) => item.product.id != productId).toList();

      emit(CartLoaded(items: List.unmodifiable(_items)));
    } catch (_) {
      emit(
        CartError(
          message: ProductStrings.failedToRemoveFromCart,
          items: List.unmodifiable(_items),
        ),
      );
    }
  }

  void clearCart() {
    try {
      _items = [];

      emit(const CartLoaded(items: []));
    } catch (_) {
      emit(
        CartError(
          message: ProductStrings.failedToClearCart,
          items: List.unmodifiable(_items),
        ),
      );
    }
  }
}
