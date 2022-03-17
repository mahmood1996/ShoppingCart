import 'package:shopping_cart/application/ports/in/add_to_cart_usecase.dart';
import 'package:shopping_cart/application/ports/out/api/add_to_cart_api_port.dart';
import 'package:shopping_cart/application/ports/out/persistence/load_cart_port.dart';
import 'package:shopping_cart/application/ports/out/platform/network_check_port.dart';
import 'package:shopping_cart/application/ports/out/persistence/update_cart_state_port.dart';
import 'package:shopping_cart/common/exceptions/domain_exception.dart';

import 'package:shopping_cart/domain/cart.dart';
import 'package:shopping_cart/domain/product.dart';

import 'package:shopping_cart/common/entities/result.dart';
import 'package:shopping_cart/common/entities/failure.dart';
import 'package:shopping_cart/common/entities/base_failure.dart';

class AddToCartService implements AddToCartUseCase {
  final NetworkCheckPort networkCheckPort;
  final LoadCartPort loadCartPort;
  final UpdateCartStatePort updateCartStatePort;
  final AddToCartAPIPort? addToCartAPIPort;

  AddToCartService({
    required this.networkCheckPort,
    required this.loadCartPort,
    required this.updateCartStatePort,
    this.addToCartAPIPort,
  });

  @override
  Future<Result<Failure, void>> addToCart(Product product) async {
    if (!await networkCheckPort.isConnected!) {
      return Result.failure(BaseFailure(type: FailureType.network));
    }
    return await _addToCart(product);
  }

  Future<Result<Failure, void>> _addToCart(Product product) async {
    try {
      return await _addProductToCart(product);
    } on DomainException catch(exception) {
      return Result.failure(BaseFailure(type: exception.failureType));
    }
  }

  Future<Result<Failure, void>> _addProductToCart(Product product) async {
    await addToCartAPIPort?.addToCart(product);
    Cart cart = (await loadCartPort.loadCart())!..addToCart(product);
    await updateCartStatePort.updateCartState(cart);
    return Result.success();
  }
}
