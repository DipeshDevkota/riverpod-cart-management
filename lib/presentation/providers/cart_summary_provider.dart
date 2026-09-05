import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cart_notifier.dart';

final cartCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartNotifierProvider).value ?? [];
  return cart.fold<int>(0, (sum, item) => sum + item.quantity);
});

final totalPriceProvider = Provider<double>((ref) {
  final cart = ref.watch(cartNotifierProvider).value ?? [];
  return cart.fold<double>(
    0,
    (sum, item) => sum + (item.product.price * item.quantity),
  );
});
