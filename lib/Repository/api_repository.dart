import 'package:dio/dio.dart';

import '../Models/category_model.dart';
import '../Models/product_model.dart';

class ApiRepository {
  final Dio _dio = Dio();

  Future<List<Category>> fetchCategories() async {
    const String url = 'https://dummyjson.com/products/categories';
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((item) => Category(name: item['name'])).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  // Hàm lấy danh sách sản phẩm
  Future<List<Product>> getAllProducts() async {
    try {
      final response = await _dio.get('https://dummyjson.com/products');
      final List<dynamic> data = response.data['products'];
      return data.map((item) => Product.fromMap(item)).toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      // Gửi yêu cầu GET tới API với danh mục làm tham số
      final response =
          await _dio.get('https://dummyjson.com/products/category/$category');

      // Kiểm tra nếu API trả về dữ liệu
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['products'];
        // Chuyển dữ liệu từ API thành danh sách các đối tượng Product
        return data.map((productData) => Product.fromMap(productData)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
