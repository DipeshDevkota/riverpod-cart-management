import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterproj/data/datasources/product_datasource.dart';
import 'package:flutterproj/data/repositories/product_repository_impl.dart';
import 'package:flutterproj/domain/entities/product.dart';
import 'package:flutterproj/domain/repositories/product_repository.dart';

final productDataSourceProvider = Provider<ProductDataSource>((ref) {
  return ProductDataSource();
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(ref.watch(productDataSourceProvider));
});

final productProvider = FutureProvider<List<Product>>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return repository.getProducts();
});
