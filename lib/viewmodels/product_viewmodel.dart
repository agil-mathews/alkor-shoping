import 'package:alkor_shopin/models/product_model.dart';
import 'package:alkor_shopin/services/product_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';



class ProductViewModel extends StateNotifier<AsyncValue<List<Product>>> {
    final ProductApiService service;

  ProductViewModel(this.service) : super(const AsyncLoading()) {
    fetchProducts();
  }

  List<Product> _allProducts = [];

  Future<void> fetchProducts() async {
    try {
      state = const AsyncLoading();
      final products = await service.fetchProducts();
      _allProducts = products;
      state = AsyncData(products);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      state = AsyncData(_allProducts);
      return;
    }

    final filtered = _allProducts
        .where(
          (product) =>
              product.title.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    state = AsyncData(filtered);
  }
}
