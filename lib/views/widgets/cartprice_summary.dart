import 'package:alkor_shopin/core/themes/color_scheme.dart';
import 'package:alkor_shopin/core/widgets/buttons/custombutton.dart';
import 'package:alkor_shopin/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPriceSummary extends ConsumerWidget {
  const CartPriceSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    final int itemCount = cartItems.fold(0, (sum, item) => sum + item.quantity);

    final double subtotal = cartItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    const double convenienceFee = 100;
    final double total = subtotal + convenienceFee;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.1)),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _priceRow("No of items", itemCount.toString()),
          _priceRow("Convenience Fees", "₹$convenienceFee"),
          _priceRow("Price Calculated", "₹$subtotal"),

          const Divider(thickness: 1),

          _priceRow("Total", "₹$total", isBold: true),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            // height: 48,
            child: CustomButton(
              text: "Pay",
              onPressed: cartItems.isEmpty ? null : () {},
              isEnabled: true,
              color: AppColors.primaryColor,
              textColor: AppColors.white,
              defaultFontSize: 18,
              widePortraitFontSize: 14,
              borderRadius: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
