import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://fakestoreapi.com"));

  Future<List<dynamic>> fetchCategories() async {
    try {
      final response = await _dio.get("/products/categories");
      return response.data ?? [];
    } catch (e) {
      throw Exception("Failed to load categories: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      final response = await _dio.get('/products');
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }


  Future<Map<String, dynamic>> fetchProductDetails(int id) async {
    try {
      final response = await _dio.get("/products/$id");
      return response.data;
    } catch (e) {
      throw Exception("Failed to load product details");
    }
  }
}
