import 'package:flutter/foundation.dart';
import 'package:flutterproj/data/datasources/cart_local_datasource.dart';
import 'package:flutterproj/data/repositories/cart_repository_impl.dart';
import 'package:flutterproj/domain/repositories/cart_repository.dart';

import '../../domain/entities/cart_item.dart';
import '../../domain/entities/product.dart';

class CartProvider extends ChangeNotifier {
  CartProvider({CartRepository? cartRepository})
    : cartRepository =
          cartRepository ?? CartRepositoryImpl(CartLocalDataSource());

  final CartRepository cartRepository;
  List<CartItem> cart = [];

  Future<void> saveCart() async {
    final cartData = cart
        .map(
          (item) => {
            'productId': item.product.id,
            'quantity': item.quantity,
            'name': item.product.name,
            'price': item.product.price,
            'image': item.product.image,
          },
        )
        .toList();

    await cartRepository.saveCart(cartData);
  }

  Future<void> loadCart() async {
    final savedCart = await cartRepository.getCart();
    final restoredCart = <CartItem>[];

    for (final savedItem in savedCart) {
      final productId = savedItem['productId'];
      final quantity = savedItem['quantity'] as int;
      final name = savedItem['name'] as String? ?? 'Product';
      final price = savedItem['price'] as num? ?? 0;
      final image = savedItem['image'] as String? ?? '';

      final product = Product(
        id: productId,
        name: name,
        price: price.toDouble(),
        image: image,
      );

      restoredCart.add(CartItem(product: product, quantity: quantity));
    }

    cart = restoredCart;
    notifyListeners();
  }

  void addToCart(Product product) {
    final index = cart.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      final newCart = [...cart];
      newCart[index] = newCart[index].copyWith(
        quantity: newCart[index].quantity + 1,
      );
      cart = newCart;
    } else {
      cart = [...cart, CartItem(product: product)];
    }

    notifyListeners();
    saveCart();
  }

  void increment(Product product) {
    final index = cart.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      final newCart = [...cart];
      newCart[index] = newCart[index].copyWith(
        quantity: newCart[index].quantity + 1,
      );
      cart = newCart;
      notifyListeners();
      saveCart();
    }
  }

  void decrement(Product product) {
    final index = cart.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      final newCart = [...cart];

      if (newCart[index].quantity > 1) {
        newCart[index] = newCart[index].copyWith(
          quantity: newCart[index].quantity - 1,
        );
      } else {
        newCart.removeAt(index);
      }

      cart = newCart;
      notifyListeners();
      saveCart();
    }
  }

  void removeFromCart(Product product) {
    cart = cart.where((item) => item.product.id != product.id).toList();
    notifyListeners();
    saveCart();
  }
}
