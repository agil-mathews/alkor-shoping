import 'package:alkor_shopin/providers/product_provider.dart';
import 'package:alkor_shopin/providers/wishlist_provider.dart';
import 'package:alkor_shopin/views/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistPage extends ConsumerWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistIds = ref.watch(wishlistProvider);
    final products = ref.watch(productProvider).value ?? [];

    final wishlistProducts =
        products.where((p) => wishlistIds.contains(p.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        centerTitle: true,
      ),
      body: wishlistProducts.isEmpty
          ? const Center(child: Text('No items in wishlist'))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: wishlistProducts.length,
              itemBuilder: (_, index) =>
                  ProductCard(product: wishlistProducts[index]),
            ),
    );
  }
}
