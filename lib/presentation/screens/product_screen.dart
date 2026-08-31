import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterproj/presentation/screens/cart_screen.dart';

import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    context.read<CartProvider>().loadCart();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final cart = context.watch<CartProvider>().cart;
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

      body: productProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : productProvider.errorMessage != null
          ? Center(child: Text(productProvider.errorMessage!))
          : ListView.builder(
              itemCount: productProvider.products.length,

              itemBuilder: (context, index) {
                final product = productProvider.products[index];

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
                      context.read<CartProvider>().addToCart(product);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Item added to cart")),
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
