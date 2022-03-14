import 'dart:async';
import 'package:shopping_cart/application/ports/in/add_to_cart_usecase.dart';
import 'package:shopping_cart/application/ports/in/delete_from_cart_usecase.dart';
import 'package:shopping_cart/application/ports/in/empty_cart_usecase.dart';
import 'package:shopping_cart/application/ports/in/get_cart_usecase.dart';
import 'package:shopping_cart/application/ports/in/remove_from_cart_usecase.dart';
import 'package:shopping_cart/domain/cart.dart';
import 'package:shopping_cart/domain/product.dart';

class RealTimeCartAdapter {
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final GetCartUseCase getCartUseCase;
  final DeleteFromCartUseCase deleteFromCartUseCase;
  final EmptyCartUseCase emptyCartUseCase;
  final StreamController<Cart> _streamController;

  RealTimeCartAdapter({
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.getCartUseCase,
    required this.deleteFromCartUseCase,
    required this.emptyCartUseCase,
  }) : _streamController = StreamController<Cart>.broadcast();

  Stream<Cart> onCartChanged() => _streamController.stream;

  Future<Cart> _currentCart() async => await _streamController.stream.first;

  Future<void> addToCart(Product product) async {
    var result = await addToCartUseCase.addToCart(product);
    if (result.isSuccess) await _addToCart(product);
  }

  Future<void> _addToCart(Product product) async {
    _streamController.sink.add((await _currentCart())..addToCart(product));
  }

  Future<void> removeFromCart(int productId) async {
    var result = await removeFromCartUseCase.removeFromCart(productId);
    if (result.isSuccess) await _removeFromCart(productId);
  }

  Future<void> _removeFromCart(int productId) async {
    _streamController.sink
        .add((await _currentCart())..removeFromCart(productId));
  }

  Future<void> deleteFromCart(int productId) async {
    var result = await deleteFromCartUseCase.deleteFromCart(productId);
    if (result.isSuccess) await _deleteFromCart(productId);
  }

  Future<void> _deleteFromCart(int productId) async {
    _streamController.sink
        .add((await _currentCart())..deleteFromCart(productId));
  }

  Future<void> emptyCart() async {
    var result = await emptyCartUseCase.emptyCart();
    if (result.isSuccess) _streamController.sink.add(Cart());
  }
}
