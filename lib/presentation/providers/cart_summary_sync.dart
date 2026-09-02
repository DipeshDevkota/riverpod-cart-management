import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as legacy_provider;

import '../../domain/entities/cart_item.dart';
import 'cart_notifier.dart';
import 'cart_summary_provider.dart';

class CartSummarySync extends ConsumerWidget {
  const CartSummarySync({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<List<CartItem>>(cartNotifierProvider, (previous, next) {
      legacy_provider.Provider.of<CartSummaryProvider>(
        context,
        listen: false,
      ).update(next);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      legacy_provider.Provider.of<CartSummaryProvider>(
        context,
        listen: false,
      ).update(ref.read(cartNotifierProvider));
    });

    return child;
  }
}
