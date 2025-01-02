import 'package:flutter/material.dart';

import '../Models/product_model.dart';
import '../Repository/api_repository.dart';

class ProductProvider with ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  // Hàm load tất cả sản phẩm
  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiRepository.getAllProducts();
    } catch (e) {
      print('Failed to load products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProductsByCategory(String category) async {
    _isLoading = true;
    notifyListeners();
    try {
      _products = await _apiRepository.getProductsByCategory(category);
    } catch (e) {
      _products = [];
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
