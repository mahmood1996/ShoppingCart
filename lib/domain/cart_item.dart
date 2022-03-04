import 'package:shopping_cart/domain/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}
