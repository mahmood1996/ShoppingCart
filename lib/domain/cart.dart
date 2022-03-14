import 'package:shopping_cart/domain/cart_item.dart';
import 'package:shopping_cart/domain/product.dart';

class Cart {
  late Map<int, CartItem> _items;

  Cart ({List<CartItem> items = const<CartItem> []}) {
    _items = <int, CartItem> {};
  }

  void addToCart(Product product) {
    _items[product.id] = CartItem(
        product: product, quantity: (_items[product.id]?.quantity ?? 0) + 1);
  }

  void removeFromCart(int productId) {
    if (!_items.containsKey(productId)) return;
    _items[productId] = CartItem(
        product: _items[productId]!.product,
        quantity: _items[productId]!.quantity - 1);
  }

  void deleteFromCart(int productId) {
    _items.remove(productId);
  }

  void emptyCart() {
    _items = <int, CartItem>{};
  }

  List<CartItem> get items => List.unmodifiable(_items.values);
  int get count => _items.values
      .reduce((value, element) => CartItem(
          product: element.product,
          quantity: value.quantity + element.quantity))
      .quantity;

  @override
  bool operator ==(Object other) {
    if (other is! Cart) return false;
    if (items.length != other.items.length) return false;
    return ! items.any((element) => ! other.items.contains(element));
  }
}