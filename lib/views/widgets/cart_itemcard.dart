import 'package:alkor_shopin/core/themes/color_scheme.dart';
import 'package:alkor_shopin/core/utils/mediaquery.dart';
import 'package:alkor_shopin/models/cart_model.dart';
import 'package:alkor_shopin/views/widgets/quantity_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/cart_provider.dart';

class CartItemCard extends ConsumerWidget {
  final CartItem item;

  const CartItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.product.image,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 40),
              ),
            ),

            const SizedBox(width: 12),

            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text(
                    item.product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: getResponsiveFontSize(
              context,
              defaultFontSize: 14,
              widePortraitFontSize: 12,
            ),
            fontWeight: FontWeight.bold,
          ),
                  ),

                  const SizedBox(height: 8),

                 
                  Text(
                    '₹ ${item.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor
                    ),
                  ),

                  const SizedBox(height: 8),

                  
                  Row(
                    children: [
                      QuantityButton(
                        icon: Icons.remove,
                        onTap: item.quantity > 1
                            ? () {
                                ref
                                    .read(cartProvider.notifier)
                                    .updateQuantity(
                                      item.product,
                                      item.quantity - 1,
                                    );
                              }
                            : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          item.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      QuantityButton(
                        icon: Icons.add,
                        onTap: () {
                          ref
                              .read(cartProvider.notifier)
                              .updateQuantity(
                                item.product,
                                item.quantity + 1,
                              );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red, size: 28,),
              onPressed: () {
                ref
                    .read(cartProvider.notifier)
                    .removeFromCart(item.product);
              },
            ),
          ],
        ),
      ),
    );
  }
}
