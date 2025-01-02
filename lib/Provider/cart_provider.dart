import 'package:final_ecommerce/Models/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  // Thêm sản phẩm vào giỏ
  void addToCart(Product product) {
    final existingProductIndex =
        _cartItems.indexWhere((item) => item.id == product.id);
    if (existingProductIndex == -1) {
      // Nếu chưa có sản phẩm trong giỏ, thêm sản phẩm mới
      _cartItems.add(product);
    }
    notifyListeners();
  }

  // Xóa sản phẩm khỏi giỏ
  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }
}
