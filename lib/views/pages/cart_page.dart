import 'package:alkor_shopin/providers/cart_provider.dart';
import 'package:alkor_shopin/views/widgets/cart_itemcard.dart';
import 'package:alkor_shopin/views/widgets/cartprice_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
            children: [
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: cartItems.length,
                    itemBuilder: (_, index) =>
                        CartItemCard(item: cartItems[index]),
                  ),
              ),
              const CartPriceSummary(),
            ],
          ),
      // bottomNavigationBar: cartItems.isNotEmpty
      //     ? Padding(
      //         padding: const EdgeInsets.all(12),
      //         child: ElevatedButton(
      //           onPressed: () {},
      //           child: const Text('Checkout'),
      //         ),
      //       )
      //     : null,
    );
  }
}
