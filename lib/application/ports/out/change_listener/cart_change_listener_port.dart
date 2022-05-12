import 'package:shopping_cart/shopping_cart.dart';

abstract class CartChangeListenerPort {
  void listen(Cart cart);
}