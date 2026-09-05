import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterproj/presentation/screens/cart_screen.dart';

import 'package:flutterproj/presentation/providers/cart_notifier.dart';
import 'package:flutterproj/presentation/providers/cart_summary_provider.dart';
import 'package:flutterproj/presentation/providers/product_notifier.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productNotifierProvider);
    final cartCount = ref.watch(cartCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),

        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),

              if (cartCount > 0)
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "$cartCount",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),

      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            const Center(child: Text("Unable to load products.")),
        data: (products) => ListView.builder(
          itemCount: products.length,

          itemBuilder: (context, index) {
            final product = products[index];

            return ListTile(
              leading: Image.asset(
                product.image,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),

              title: Text(product.name),

              subtitle: Text("Rs. ${product.price}"),

              trailing: ElevatedButton(
                onPressed: () {
                  ref.read(cartNotifierProvider.notifier).addToCart(product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Item added to cart")),
                  );
                },

                child: const Text("Add to Cart"),
              ),
            );
          },
        ),
      ),
    );
  }
}
