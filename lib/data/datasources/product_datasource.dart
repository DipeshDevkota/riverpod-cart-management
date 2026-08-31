import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutterproj/data/models/product_model.dart';

class ProductDataSource{
  Future<List<ProductModel>> getProducts() async{
    final jsonString = await rootBundle.loadString(
      'assets/data/products.json',
    );

    final List<dynamic> jsonData = jsonDecode(jsonString);

    return jsonData 
          .map(
            (json)=> ProductModel.fromJson(json),
          )
          .toList();
  }
}