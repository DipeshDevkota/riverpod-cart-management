import 'package:flutterproj/domain/entities/product.dart';

abstract interface class ProductRepository {
  Future<List<Product>> getProducts();
}