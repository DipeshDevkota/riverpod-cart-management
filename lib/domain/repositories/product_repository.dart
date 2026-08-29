import 'package:flutterproj/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}