import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopping_cart/application/ports/out/persistence/load_cart_port.dart';
import 'package:shopping_cart/application/ports/out/persistence/update_cart_state_port.dart';
import 'package:shopping_cart/domain/cart.dart';

class CartRepository implements LoadCartPort, UpdateCartStatePort {
  final LazyBox _cartBox;
  CartRepository._(this._cartBox);

  Future<CartRepository> getInstance() async {
    Hive.init((await getApplicationDocumentsDirectory()).path + "/cache");
    return CartRepository._(await Hive.openLazyBox("cart"));
  }

  @override
  Future<Cart> loadCart() async {
    throw UnimplementedError();
  }

  @override
  Future<void> updateCartState(Cart cart) {
    throw UnimplementedError();
  }
}