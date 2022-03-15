import 'dart:async';
import 'package:shopping_cart/application/ports/in/add_to_cart_usecase.dart';
import 'package:shopping_cart/application/ports/in/delete_from_cart_usecase.dart';
import 'package:shopping_cart/application/ports/in/empty_cart_usecase.dart';
import 'package:shopping_cart/application/ports/in/get_cart_from_cache_usecase.dart';
import 'package:shopping_cart/application/ports/in/get_cart_usecase.dart';
import 'package:shopping_cart/application/ports/in/remove_from_cart_usecase.dart';
import 'package:shopping_cart/domain/cart.dart';
import 'package:shopping_cart/domain/product.dart';
import 'package:shopping_cart/common/entities/failure.dart';
import 'package:shopping_cart/common/entities/result.dart';

class CartUIAdapter {
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final GetCartUseCase getCartUseCase;
  final DeleteFromCartUseCase deleteFromCartUseCase;
  final EmptyCartUseCase emptyCartUseCase;
  final GetCartFromCacheUseCase getCartFromCacheUseCase;
  final StreamController<Cart> _streamController;

  CartUIAdapter._(
      {required this.addToCartUseCase,
      required this.removeFromCartUseCase,
      required this.getCartUseCase,
      required this.deleteFromCartUseCase,
      required this.emptyCartUseCase,
      required this.getCartFromCacheUseCase,
      required StreamController<Cart> streamController})
      : _streamController = streamController;

  static Future<CartUIAdapter> createInstance({
    required AddToCartUseCase addToCartUseCase,
    required RemoveFromCartUseCase removeFromCartUseCase,
    required GetCartUseCase getCartUseCase,
    required DeleteFromCartUseCase deleteFromCartUseCase,
    required EmptyCartUseCase emptyCartUseCase,
    required GetCartFromCacheUseCase getCartFromCacheUseCase,
  }) async {
    return CartUIAdapter._(
        addToCartUseCase: addToCartUseCase,
        removeFromCartUseCase: removeFromCartUseCase,
        getCartUseCase: getCartUseCase,
        deleteFromCartUseCase: deleteFromCartUseCase,
        emptyCartUseCase: emptyCartUseCase,
        getCartFromCacheUseCase: getCartFromCacheUseCase,
        streamController: StreamController<Cart>.broadcast()
          ..sink.add(await getCartFromCacheUseCase.getCart()));
  }

  Stream<Cart> onCartChanged() => _streamController.stream;

  Future<Result<Failure, void>> addToCart(Product product) async {
    var result = await addToCartUseCase.addToCart(product);
    if (result.isSuccess) await _loadCartFromCache();
    return result;
  }

  Future<Result<Failure, void>> removeFromCart(int productId) async {
    var result = await removeFromCartUseCase.removeFromCart(productId);
    if (result.isSuccess) await _loadCartFromCache();
    return result;
  }

  Future<Result<Failure, void>> deleteFromCart(int productId) async {
    var result = await deleteFromCartUseCase.deleteFromCart(productId);
    if (result.isSuccess) await _loadCartFromCache();
    return result;
  }

  Future<Result<Failure, void>> emptyCart() async {
    var result = await emptyCartUseCase.emptyCart();
    if (result.isSuccess) await _loadCartFromCache();
    return result;
  }

  Future<Result<Failure, void>> loadCart() async {
    var result = await getCartUseCase.getCart();
    if (result.isSuccess) await _loadCartFromCache();
    return result;
  }

  Future<void> _loadCartFromCache() async {
    _streamController.sink.add(await getCartFromCacheUseCase.getCart());
  }
}
