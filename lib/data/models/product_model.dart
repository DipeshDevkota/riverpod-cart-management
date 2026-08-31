import 'package:flutterproj/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
    );
  }
  ProductModel copyWith({int? id, String? name, double? price, String? image}) {
    return ProductModel(
      id: id ?? super.id,
      name: name ?? super.name,
      price: price ?? super.price,
      image: image ?? super.image,
    );
  }
}
