import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterproj/data/datasources/cart_local_datasource.dart';
import 'package:flutterproj/data/repositories/cart_repository_impl.dart';
import 'package:flutterproj/domain/repositories/cart_repository.dart';

import '../../domain/entities/cart_item.dart';
import '../../domain/entities/product.dart';

class CartNotifier extends AsyncNotifier<List<CartItem>> {
  late final CartRepository cartRepository;

  @override
  Future<List<CartItem>> build() async {
    cartRepository = CartRepositoryImpl(CartLocalDataSource());
    return _loadCart();
  }

  Future<List<CartItem>> _loadCart() async {
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

    return restoredCart;
  }

  Future<void> _saveCart(List<CartItem> cart) async {
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

  void addToCart(Product product) {
    final current = state.value ?? [];
    final index = current.indexWhere((item) => item.product.id == product.id);

    List<CartItem> newCart;
    if (index != -1) {
      newCart = [...current];
      newCart[index] = newCart[index].copyWith(
        quantity: newCart[index].quantity + 1,
      );
    } else {
      newCart = [...current, CartItem(product: product)];
    }

    state = AsyncData(newCart);
    _saveCart(newCart);
  }

  void increment(Product product) {
    final current = state.value ?? [];
    final index = current.indexWhere((item) => item.product.id == product.id);
    if (index == -1) return;

    final newCart = [...current];
    newCart[index] = newCart[index].copyWith(
      quantity: newCart[index].quantity + 1,
    );

    state = AsyncData(newCart);
    _saveCart(newCart);
  }

  void decrement(Product product) {
    final current = state.value ?? [];
    final index = current.indexWhere((item) => item.product.id == product.id);
    if (index == -1) return;

    final newCart = [...current];
    if (newCart[index].quantity > 1) {
      newCart[index] = newCart[index].copyWith(
        quantity: newCart[index].quantity - 1,
      );
    } else {
      newCart.removeAt(index);
    }

    state = AsyncData(newCart);
    _saveCart(newCart);
  }

  void removeFromCart(Product product) {
    final current = state.value ?? [];
    final newCart = current
        .where((item) => item.product.id != product.id)
        .toList();

    state = AsyncData(newCart);
    _saveCart(newCart);
  }
}

final cartNotifierProvider =
    AsyncNotifierProvider<CartNotifier, List<CartItem>>(CartNotifier.new);
