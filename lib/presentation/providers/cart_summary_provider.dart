import 'package:flutter/material.dart';

import '../../domain/entities/cart_item.dart';

class CartSummaryProvider extends ChangeNotifier {
  int cartCount = 0;
  double totalPrice = 0;

  void update(List<CartItem> cart) {
    final newCount = cart.fold<int>(0, (sum, item) => sum + item.quantity);
    final newTotal = cart.fold<double>(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );

    if (newCount != cartCount || newTotal != totalPrice) {
      cartCount = newCount;
      totalPrice = newTotal;
      notifyListeners();
    }
  }
}
