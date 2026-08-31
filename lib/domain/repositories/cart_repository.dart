abstract interface class CartRepository {
  Future<void> saveCart(List<Map<String, dynamic>> cart);

  Future<List<Map<String, dynamic>>> getCart();

  Future<void> clearCart();
}
