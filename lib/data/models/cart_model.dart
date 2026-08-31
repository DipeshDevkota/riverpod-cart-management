import 'package:flutterproj/domain/entities/cart_item.dart';
import 'package:flutterproj/domain/entities/product.dart';

class CartModel extends CartItem {
  CartModel({required super.product, super.quantity = 1});

  @override
  CartModel copyWith({Product? product, int? quantity}) {
    return CartModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {"productId": product.id, "quantity": quantity};
  }
}
