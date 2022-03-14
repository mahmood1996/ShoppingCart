import 'package:shopping_cart/application/ports/in/remove_from_cart_usecase.dart';
import 'package:shopping_cart/application/ports/out/api/remove_from_cart_api_port.dart';
import 'package:shopping_cart/application/ports/out/persistence/load_cart_port.dart';
import 'package:shopping_cart/application/ports/out/platform/network_check_port.dart';
import 'package:shopping_cart/application/ports/out/persistence/update_cart_state_port.dart';

import 'package:shopping_cart/domain/cart.dart';

import 'package:shopping_cart/shared_kernels/entities/result.dart';
import 'package:shopping_cart/shared_kernels/entities/failure.dart';
import 'package:shopping_cart/shared_kernels/entities/base_failure.dart';


class RemoveFromCartService implements RemoveFromCartUseCase {
  final RemoveFromCartAPIPort? removeFromCartAPIPort;
  final LoadCartPort loadCartPort;
  final UpdateCartStatePort updateCartStatePort;
  final NetworkCheckPort networkCheckPort;

  RemoveFromCartService(
      {this.removeFromCartAPIPort,
      required this.loadCartPort,
      required this.networkCheckPort,
      required this.updateCartStatePort});

  @override
  Future<Result<Failure, void>> removeFromCart(int productId) async {
    if (!await networkCheckPort.isConnected) {
      return Result.failure(BaseFailure(type: FailureType.network));
    }
    return await _removeFromCart(productId);
  }

  Future<Result<Failure, void>> _removeFromCart(int productId) async {
    Cart cart = await loadCartPort.loadCart()
      ..removeFromCart(productId);
    await removeFromCartAPIPort?.removeFromCart(productId);
    updateCartStatePort.updateCartState(cart);
    return Result.success();
  }
}
