import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/product.dart';
import '../domain/entities/cart_item.dart';
import '../data/datasources/cart_local_datasource.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  final CartLocalDataSource localDataSource =
      CartLocalDataSource();

  @override
  List<CartItem> build() {
    return [];
  }

  Future<void> saveCart() async {
    final cartData = state
        .map((item) => item.toJson())
        .toList();

    await localDataSource.saveCart(cartData);
  }
Future<void> loadCart(List<Product> products) async {
  final savedCart = await localDataSource.getCart();

  final restoredCart = <CartItem>[];

  for (final savedItem in savedCart) {
    final productId = savedItem["productId"];
    final quantity = savedItem["quantity"];

    final product = products.firstWhere(
      (product) => product.id == productId,
    );

    restoredCart.add(
      CartItem(
        product: product,
        quantity: quantity,
      ),
    );
  }

  state = restoredCart;
}

  void addToCart(Product product) {
    final index = state.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      final newCart = [...state];

      newCart[index] = newCart[index].copyWith(
        quantity: newCart[index].quantity + 1,
      );

      state = newCart;
    } else {
      state = [
        ...state,
        CartItem(product: product),
      ];
    }

    saveCart();
  }

  void increment(Product product) {
    final index = state.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      final newCart = [...state];

      newCart[index] = newCart[index].copyWith(
        quantity: newCart[index].quantity + 1,
      );

      state = newCart;

      saveCart();
    }
  }

  void decrement(Product product) {
    final index = state.indexWhere(
      (item) => item.product.id == product.id,
    );

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

      saveCart();
    }
  }

  void removeFromCart(Product product) {
    state = state
        .where(
          (item) => item.product.id != product.id,
        )
        .toList();

    saveCart();
  }
}

final cartProvider =
    NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);