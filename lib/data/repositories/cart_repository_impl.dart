import 'package:flutterproj/data/datasources/cart_local_datasource.dart';
import 'package:flutterproj/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource cartLocalDataSource;

  CartRepositoryImpl(this.cartLocalDataSource);

  @override
  Future<void> saveCart(List<Map<String, dynamic>> cart) async {
    return await cartLocalDataSource.saveCart(cart);
  }

  @override
  Future<List<Map<String, dynamic>>> getCart() async {
    return await cartLocalDataSource.getCart();
  }

  @override
  Future<void> clearCart() {
    return cartLocalDataSource.clearCart();
  }
}
