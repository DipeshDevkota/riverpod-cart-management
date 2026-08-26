import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterproj/screens/cart_screen.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';


class ProductScreen extends ConsumerWidget {
  ProductScreen({super.key});

  final List<Product> products = [
    Product(id: 1, name: "Laptop", price: 80000, image:"assets/images/lp.jpg"),
    Product(id: 2, name: "Phone", price: 40000, image:"assets/images/phone.jpg"),
    Product(id: 3, name: "Headphones", price: 5000, image:"assets/images/headphone.jpg"),
  ];

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products"),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder:(context)=>const CartScreen(),),);
          }),
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
            subtitle: Text("Rs.${product.price}"),
            trailing: ElevatedButton(
              onPressed: () {
                ref.read(cartProvider.notifier).addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item added to cart")));
              },
              child: const Text("Add to Cart"),
            ),
          );
        },
      ),
    );
  }
}
