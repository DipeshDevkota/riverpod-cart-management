import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

class CartNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    return [];
  }

  void addToCart(Product product) {
    state = [...state, product];
  }

  void removeFromCart(Product product) {
    final newCart = [...state];
    newCart.remove(product);
    state = newCart;
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<Product>>(
  CartNotifier.new,
);
