import 'package:flutter_riverpod/legacy.dart';

class WishlistViewModel extends StateNotifier<Set<int>> {
  WishlistViewModel() : super({});

  void toggleWishlist(int productId) {
    if (state.contains(productId)) {
      state = {...state}..remove(productId);
    } else {
      state = {...state, productId};
    }
  }

  bool isWishlisted(int id) => state.contains(id);
}
