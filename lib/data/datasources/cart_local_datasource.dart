import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartLocalDataSource {
  static const String cartKey = "cart";

  Future<void> saveCart(List<Map<String, dynamic>> cart) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode(cart);

    await prefs.setString(cartKey, jsonString);
  }

  Future<List<Map<String, dynamic>>> getCart() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(cartKey);

    if (jsonString == null) {
      return [];
    }

    final List<dynamic> decodedData = jsonDecode(jsonString);

    return decodedData
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(cartKey);
  }
}