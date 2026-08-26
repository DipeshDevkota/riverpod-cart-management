import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),

      body: cart.isEmpty
          ? const Center(
              child: Text("Your cart is empty", style: TextStyle(fontSize: 20)),
            )
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: ((context, index) {
                final product = cart[index];
                return ListTile(
                  leading: Image.asset(
                    product.image,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Text("Rs.${product.price}"),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref.read(cartProvider.notifier).removeFromCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item removed")));
                    },
                  ),
                );
              }),
            ),
    );
  }
}
