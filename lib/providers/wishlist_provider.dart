import 'package:alkor_shopin/viewmodels/wishlist_viewmodel.dart';
import 'package:flutter_riverpod/legacy.dart';

final wishlistProvider =
    StateNotifierProvider<WishlistViewModel, Set<int>>(
  (ref) => WishlistViewModel(),
);

