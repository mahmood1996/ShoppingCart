import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopping_cart/adapters/persistence/cart_mapper.dart';
import 'package:shopping_cart/application/ports/out/persistence/load_cart_port.dart';
import 'package:shopping_cart/application/ports/out/persistence/update_cart_state_port.dart';
import 'package:shopping_cart/domain/cart.dart';
import 'package:shopping_cart/domain/product.dart';
import 'package:shopping_cart/common/interfaces/object_data_mapper.dart';

class CartRepository implements LoadCartPort, UpdateCartStatePort {
  final LazyBox<String> _cartBox;
  late CartMapper _cartMapper;

  CartRepository._(this._cartBox, Mapper<dynamic, Product> productMapper) {
    _cartMapper = CartMapper(productMapper: productMapper);
  }

  Future<CartRepository> getInstance(
      Mapper<dynamic, Product> productMapper) async {
    Hive.init((await getApplicationDocumentsDirectory()).path + "/cache");
    return CartRepository._(await Hive.openLazyBox("cart"), productMapper);
  }

  @override
  Future<Cart> loadCart() async {
    return _cartMapper
        .decode(json.decode((await _cartBox.get("data", defaultValue: "[]"))!));
  }

  @override
  Future<void> updateCartState(Cart cart) async {
    return await _cartBox.put("data", json.encode(_cartMapper.encode(cart)));
  }
}

/// loadCart       -> onCartChange
/// addToCart      -> onCartChange
/// removeFromCart -> onCartChange
/// deleteFromCart -> onCartChange
/// emptyCart      -> onCartChange