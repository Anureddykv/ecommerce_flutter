// lib/features/home/data/home_repository.dart

import '../network/api_service.dart';

class HomeRepository {
  final ApiService apiService;

  HomeRepository(this.apiService);

  Future<List<String>> getCategories() async {
    final categories = await apiService.fetchCategories();
    if (categories is! List) throw Exception("Invalid categories data");
    return List<String>.from(categories);
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    final products = await apiService.fetchProducts();
    return List<Map<String, dynamic>>.from(products);
  }
}
