import 'package:shopping_cart/domain/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  const CartItem({
    required this.product,
    this.quantity = 1,
  });

  @override
  int get hashCode => Object.hash(product, quantity);

  @override
  bool operator ==(Object other) {
    if (other is! CartItem) return false;
    return quantity == other.quantity && product == other.product;
  }
}
