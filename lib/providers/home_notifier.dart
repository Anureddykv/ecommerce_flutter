import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositry/home_repository.dart';
import '../network/api_service.dart';


final apiServiceProvider = Provider((ref) => ApiService());
final homeRepositoryProvider = Provider((ref) => HomeRepository(ref.read(apiServiceProvider)));

final categoriesProvider = FutureProvider<List<String>>((ref) async {
  return ref.read(homeRepositoryProvider).getCategories();
});

final productsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return await apiService.fetchProducts();
});
