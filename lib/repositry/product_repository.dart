
import 'package:ecommerce/network/api_service.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository(this.apiService);

  Future<Map<String, dynamic>> getProductDetails(int id) async {
    return await apiService.fetchProductDetails(id);
  }
}
