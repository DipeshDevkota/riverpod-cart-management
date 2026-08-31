import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final cart = cartProvider.cart;

    double totalPrice = 0;

    for (final item in cart) {
      totalPrice += item.product.price * item.quantity;
    }

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
                                cartProvider.decrement(item.product);
                              },
                              icon: const Icon(Icons.remove),
                            ),

                            Text(
                              "${item.quantity}",
                              style: const TextStyle(fontSize: 18),
                            ),

                            IconButton(
                              onPressed: () {
                                cartProvider.increment(item.product);
                              },
                              icon: const Icon(Icons.add),
                            ),

                            IconButton(
                              onPressed: () {
                                cartProvider.removeFromCart(item.product);
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
