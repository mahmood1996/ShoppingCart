import 'package:shopping_cart/domain/cart_item.dart';
import 'package:shopping_cart/domain/product.dart';

class Cart {
  late Map<int, CartItem> _items;

  Cart({List<CartItem> items = const <CartItem>[]}) {
    _items = <int, CartItem>{
      for (var element in items) element.product.id: element
    };
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

  int get count => items
      .map<int>((element) => element.quantity)
      .reduce((value, element) => value + element);

  double get total => items
      .map<double>((element) => element.total)
      .reduce((value, element) => value + element);

  @override
  int get hashCode => Object.hashAll([_items]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Cart) return false;
    if (items.length != other.items.length) return false;
    return !items.any((element) => !other.items.contains(element));
  }
}
