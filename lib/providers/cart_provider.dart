import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/product.dart';
import '../models/cart_item.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    return [];
  }

  void addToCart(Product product) {
    final index = state.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      // Product already exists
      final newCart = [...state];

      newCart[index].quantity++;

      state = newCart;
    } else {
      // Product doesn't exist
      state = [
        ...state,
        CartItem(product: product),
      ];
    }
  }

  void increment(Product product) {
    final newCart = [...state];

    final index = newCart.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      newCart[index].quantity++;
      state = newCart;
    }
  }

  void decrement(Product product) {
    final newCart = [...state];

    final index = newCart.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      if (newCart[index].quantity > 1) {
        newCart[index].quantity--;
      } else {
        newCart.removeAt(index);
      }

      state = newCart;
    }
  }

  void removeFromCart(Product product) {
    state = state
        .where((item) => item.product.id != product.id)
        .toList();
  }
}

final cartProvider =
    NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);