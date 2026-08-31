import 'package:flutter/material.dart';
import '../../data/datasources/product_datasource.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepositoryImpl productRepositoryImpl = ProductRepositoryImpl(
    ProductDataSource(),
  );

  List<Product> products = [];
  bool isLoading = false;
  String? errorMessage;

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      products = await productRepositoryImpl.getProducts();
    } catch (error) {
      errorMessage = 'Unable to load products.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
