import 'package:alkor_shopin/providers/cart_provider.dart';
import 'package:alkor_shopin/providers/product_provider.dart';
import 'package:alkor_shopin/views/pages/cart_page.dart';
import 'package:alkor_shopin/views/widgets/category.dart';
import 'package:alkor_shopin/views/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductHomePage extends ConsumerWidget {
  const ProductHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final productState = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  // DefaultTabController.of(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CartPage()),
                  );
                },
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.red,
                    child: Text(
                      cartItems.length.toString(),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
     body: productState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Text(
            error.toString(),
            style: const TextStyle(color: Colors.red),
          ),
        ),
        data: (products) {
          if (products.isEmpty) {
            return const Center(
              child: Text('No products found'),
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 2;

              if (constraints.maxWidth >= 1024) {
                crossAxisCount = 4; // Desktop
              } else if (constraints.maxWidth >= 600) {
                crossAxisCount = 3; // Tablet
              }

              return Column(
                children: [
                  /// 🔍 SEARCH BAR
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              // ref
              //     .read(productProvider.notifier)
              //     .searchProducts(value);
            },
          ),
        ),

                /// 🟢 CATEGORIES (HORIZONTAL)
        SizedBox(
          height: 95,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: demoCategories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, index) {
              final category = demoCategories[index];
              return Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: NetworkImage(category.image),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category.name,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              );
            },
          ),
        ),

        const SizedBox(height: 8),

                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: products[index]);
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
