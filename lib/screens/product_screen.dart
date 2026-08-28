import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterproj/screens/cart_screen.dart';

import '../domain/entities/product.dart';
import '../providers/cart_provider.dart';

class ProductScreen extends ConsumerWidget {
  ProductScreen({super.key});

  final List<Product> products = [
    Product(
      id: 1,
      name: "Laptop",
      price: 80000,
      image: "assets/images/lp.jpg",
    ),
    Product(
      id: 2,
      name: "Phone",
      price: 40000,
      image: "assets/images/phone.jpg",
    ),
    Product(
      id: 3,
      name: "Headphones",
      price: 5000,
      image: "assets/images/headphone.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    int cartCount = 0;

    for (final item in cart) {
      cartCount += item.quantity;
    }

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
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
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

      body: ListView.builder(
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

            subtitle: Text(
              "Rs. ${product.price}",
            ),

            trailing: ElevatedButton(
              onPressed: () {
                ref
                    .read(cartProvider.notifier)
                    .addToCart(product);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Item added to cart"),
                  ),
                );
              },

              child: const Text("Add to Cart"),
            ),
          );
        },
      ),
    );
  }
}