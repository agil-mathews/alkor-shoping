import 'package:alkor_shopin/providers/product_provider.dart';
import 'package:alkor_shopin/views/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
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

              return GridView.builder(
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
              );
            },
          );
        },
      ),
    );
  }
}
