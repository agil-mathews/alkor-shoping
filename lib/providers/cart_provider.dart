import 'package:alkor_shopin/models/cart_model.dart';
import 'package:alkor_shopin/viewmodels/cart_viewmodel.dart';
import 'package:flutter_riverpod/legacy.dart';

final cartProvider =
    StateNotifierProvider<CartViewModel, List<CartItem>>(
  (ref) => CartViewModel(),
);

// final cartCountProvider = Provider<int>((ref) {
//   return ref.watch(cartProvider).length;
// });