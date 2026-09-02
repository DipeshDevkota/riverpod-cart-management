import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import 'presentation/providers/cart_summary_provider.dart';
import 'presentation/providers/cart_summary_sync.dart';
import 'presentation/providers/product_provider.dart';
import 'presentation/screens/product_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => CartSummaryProvider()),
        ],
        child: const CartSummarySync(child: MyApp()),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProductScreen(),
    );
  }
}
