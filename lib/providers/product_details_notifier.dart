import 'package:ecommerce/repositry/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_notifier.dart';


final productRepositoryProvider = Provider((ref) => ProductRepository(ref.read(apiServiceProvider)));

final productDetailsProvider = FutureProvider.family<Map<String, dynamic>, int>((ref, id) async {
  return ref.read(productRepositoryProvider).getProductDetails(id);
});
