import 'package:shopping_cart/domain/cart.dart';
import 'package:shopping_cart/domain/cart_item.dart';
import 'package:shopping_cart/domain/product.dart';
import 'package:shopping_cart/common/interfaces/object_data_mapper.dart';

class CartMapper {
  final Mapper<dynamic, Product> productMapper;
  CartMapper({required this.productMapper});

  Cart decode(var data) {
    return Cart(items: data.map<CartItem>(_parseCartItem).toList());
  }

  CartItem _parseCartItem(var data) {
    return CartItem(
        product: productMapper.decode(data["product"]),
        quantity: data["quantity"]);
  }

  List<Map<String, dynamic>> encode(Cart cart) {
    return cart.items.map<Map<String, dynamic>>(_cartItemAsMap).toList();
  }

  Map<String, dynamic> _cartItemAsMap(CartItem item) => {
        "quantity": item.quantity,
        "product": productMapper.encode(item.product)
      };
}