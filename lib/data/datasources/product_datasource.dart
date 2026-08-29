import 'dart:convert';

import 'package:flutterproj/models/product_model.dart';
import 'package:flutter/services.dart';

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