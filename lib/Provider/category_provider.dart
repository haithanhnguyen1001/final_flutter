import 'package:flutter/material.dart';

import '../Models/category_model.dart';
import '../Repository/api_repository.dart';

class CategoryProvider with ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();
  List<Category> _categories = [];
  bool _isLoading = false;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();
    try {
      _categories = await _apiRepository.fetchCategories();
    } catch (e) {
      print('Error loading categories: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
