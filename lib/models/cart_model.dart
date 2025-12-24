import 'package:alkor_shopin/models/product_model.dart';

class CartItem {
  final Product product;
  final int quantity;
  final double price;

  CartItem({
    required this.product,
    required this.quantity,
   required this.price
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      product: product,
      quantity: quantity ?? this.quantity, price: price,
    );
  }
}
