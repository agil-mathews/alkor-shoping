import 'package:alkor_shopin/models/product_model.dart';
import 'package:alkor_shopin/services/product_services.dart';
import 'package:alkor_shopin/viewmodels/product_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final productServiceProvider = Provider(
  (ref) => ProductApiService(),
);

final productProvider =
    StateNotifierProvider<ProductViewModel, AsyncValue<List<Product>>>(
  (ref) => ProductViewModel(ref.read(productServiceProvider)),
);

// final productDetailsProvider =
//     StateNotifierProvider<ProductDetailsViewModel, AsyncValue<Product>>(
//   (ref) => ProductDetailsViewModel(ref.read(productServiceProvider)),
// );