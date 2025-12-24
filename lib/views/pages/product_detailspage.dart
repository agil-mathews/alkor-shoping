import 'package:alkor_shopin/core/themes/color_scheme.dart';
import 'package:alkor_shopin/core/utils/mediaquery.dart';
import 'package:alkor_shopin/core/widgets/buttons/custombutton.dart';
import 'package:alkor_shopin/models/product_model.dart';
import 'package:alkor_shopin/providers/cart_provider.dart';
import 'package:alkor_shopin/providers/wishlist_provider.dart';
import 'package:alkor_shopin/views/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailPage extends ConsumerWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final wishlistItems = ref.watch(wishlistProvider);

    final isInCart = cartItems.any((item) => item.product.id == product.id);

    final isWishlisted = wishlistItems.contains(product.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: getResponsiveFontSize(
              context,
              defaultFontSize: 20,
              widePortraitFontSize: 12,
            ),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  // DefaultTabController.of(context);
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const CartPage()));
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
                      style: const TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                height: 250,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              product.title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: getResponsiveFontSize(
                  context,
                  defaultFontSize: 19,
                  widePortraitFontSize: 12,
                ),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "₹${product.price}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              product.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: getResponsiveFontSize(
                  context,
                  defaultFontSize: 14,
                  widePortraitFontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: CustomButton(
                text: isInCart ? "Remove" : "Add to Cart",
                onPressed: () {
                  if (isInCart) {
                    ref.read(cartProvider.notifier).removeFromCart(product);
                  } else {
                    ref.read(cartProvider.notifier).addToCart(product);
                  }
                },
                isEnabled: true,
                color: AppColors.primaryColor,
                textColor: AppColors.white,
                defaultFontSize: 16,
                widePortraitFontSize: 14,
                borderRadius: 18,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () {
                  ref
                      .read(wishlistProvider.notifier)
                      .toggleWishlist(product.id);
                },
                child: Text(
                  isWishlisted ? "Remove from Wishlist" : "Add to Wishlist",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
