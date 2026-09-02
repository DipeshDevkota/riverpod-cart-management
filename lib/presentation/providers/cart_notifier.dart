import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterproj/data/datasources/cart_local_datasource.dart';
import 'package:flutterproj/data/repositories/cart_repository_impl.dart';
import 'package:flutterproj/domain/repositories/cart_repository.dart';

import '../../domain/entities/cart_item.dart';
import '../../domain/entities/product.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  late final CartRepository cartRepository;

  @override
  List<CartItem> build() {
    cartRepository = CartRepositoryImpl(CartLocalDataSource());
    _loadCart();
    return [];
  }

  Future<void> _loadCart() async {
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

    state = restoredCart;
  }

  Future<void> _saveCart() async {
    final cartData = state
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
    final index = state.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      final newCart = [...state];
      newCart[index] = newCart[index].copyWith(
        quantity: newCart[index].quantity + 1,
      );
      state = newCart;
    } else {
      state = [...state, CartItem(product: product)];
    }

    _saveCart();
  }

  void increment(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      final newCart = [...state];
      newCart[index] = newCart[index].copyWith(
        quantity: newCart[index].quantity + 1,
      );
      state = newCart;
      _saveCart();
    }
  }

  void decrement(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      final newCart = [...state];

      if (newCart[index].quantity > 1) {
        newCart[index] = newCart[index].copyWith(
          quantity: newCart[index].quantity - 1,
        );
      } else {
        newCart.removeAt(index);
      }

      state = newCart;
      _saveCart();
    }
  }

  void removeFromCart(Product product) {
    state = state.where((item) => item.product.id != product.id).toList();
    _saveCart();
  }
}

final cartNotifierProvider = NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);
