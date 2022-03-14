import 'package:shopping_cart/domain/cart.dart';

class CartMapper<T> {
  Cart decode(T data) {
    throw UnimplementedError();
  }

  T encode(Cart cart) {
    throw UnimplementedError();
  }
}