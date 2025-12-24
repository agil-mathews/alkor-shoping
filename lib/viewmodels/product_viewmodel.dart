import 'package:alkor_shopin/models/product_model.dart';
import 'package:alkor_shopin/services/product_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ProductViewModel extends StateNotifier<AsyncValue<List<Product>>> {
  final ProductApiService service;

  ProductViewModel(this.service) : super(const AsyncLoading()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final products = await service.fetchProducts();
      state = AsyncData(products);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
