import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/product_datasource.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product.dart';

class ProductNotifier extends AsyncNotifier<List<Product>> {
  late final ProductRepositoryImpl productRepositoryImpl;

  @override
  Future<List<Product>> build() async {
    productRepositoryImpl = ProductRepositoryImpl(ProductDataSource());
    return productRepositoryImpl.getProducts();
  }

  Future<void> fetchProducts() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => productRepositoryImpl.getProducts());
  }
}

final productNotifierProvider =
    AsyncNotifierProvider<ProductNotifier, List<Product>>(ProductNotifier.new);
