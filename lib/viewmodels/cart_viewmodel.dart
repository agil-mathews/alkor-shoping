import 'package:alkor_shopin/models/cart_model.dart';
import 'package:alkor_shopin/models/product_model.dart';
import 'package:flutter_riverpod/legacy.dart';

class CartViewModel extends StateNotifier<List<CartItem>> {
  CartViewModel() : super([]);

  void addToCart(Product product) {
    final index =
        state.indexWhere((item) => item.product.id == product.id);

    if (index == -1) {
      state = [...state, CartItem(product: product, quantity: 1, )];
    } else {
      state[index] =
          state[index].copyWith(quantity: state[index].quantity + 1);
      state = [...state];
    }
  }

  void removeFromCart(Product product) {
    state = state.where((e) => e.product.id != product.id).toList();
  }

  void updateQuantity(Product product, int qty) {
    state = state
        .map((item) => item.product.id == product.id
            ? item.copyWith(quantity: qty)
            : item)
        .toList();
  }

  double get totalPrice =>
      state.fold(0, (sum, item) => sum + item.product.price * item.quantity);
}
