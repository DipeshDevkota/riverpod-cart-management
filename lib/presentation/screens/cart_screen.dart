import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import 'package:flutterproj/presentation/providers/cart_notifier.dart';
import 'package:flutterproj/presentation/providers/cart_summary_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Core cart items live in Riverpod.
    final cart = ref.watch(cartNotifierProvider);
    final cartNotifier = ref.read(cartNotifierProvider.notifier);

    // Derived total lives in the plain provider package.
    final totalPrice = context.watch<CartSummaryProvider>().totalPrice;

    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),

      body: cart.isEmpty
          ? const Center(
              child: Text("Your cart is empty", style: TextStyle(fontSize: 20)),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];

                      return ListTile(
                        title: Text(item.product.name),

                        subtitle: Text("Rs. ${item.product.price}"),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                cartNotifier.decrement(item.product);
                              },
                              icon: const Icon(Icons.remove),
                            ),

                            Text(
                              "${item.quantity}",
                              style: const TextStyle(fontSize: 18),
                            ),

                            IconButton(
                              onPressed: () {
                                cartNotifier.increment(item.product);
                              },
                              icon: const Icon(Icons.add),
                            ),

                            IconButton(
                              onPressed: () {
                                cartNotifier.removeFromCart(item.product);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Total: Rs. $totalPrice",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
