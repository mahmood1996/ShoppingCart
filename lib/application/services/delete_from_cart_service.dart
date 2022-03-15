import 'package:shopping_cart/application/ports/in/delete_from_cart_usecase.dart';
import 'package:shopping_cart/application/ports/out/persistence/load_cart_port.dart';
import 'package:shopping_cart/application/ports/out/platform/network_check_port.dart';
import 'package:shopping_cart/application/ports/out/api/delete_from_cart_api_port.dart';
import 'package:shopping_cart/application/ports/out/persistence/update_cart_state_port.dart';

import 'package:shopping_cart/domain/cart.dart';

import 'package:shopping_cart/common/entities/result.dart';
import 'package:shopping_cart/common/entities/failure.dart';
import 'package:shopping_cart/common/entities/base_failure.dart';

class DeleteFromCartService implements DeleteFromCartUseCase {
  final LoadCartPort loadCartPort;
  final DeleteFromCartAPIPort? deleteFromCartAPIPort;
  final UpdateCartStatePort updateCartStatePort;
  final NetworkCheckPort networkCheckPort;

  DeleteFromCartService({
    required this.loadCartPort,
    required this.networkCheckPort,
    required this.updateCartStatePort,
    this.deleteFromCartAPIPort
  });

  @override
  Future<Result<Failure, void>> deleteFromCart(int productId) async {
    if (! await networkCheckPort.isConnected){
      return Result.failure(BaseFailure(type: FailureType.network));
    }
    return await _deleteFromCart(productId);
  }

  Future<Result<Failure, void>> _deleteFromCart(int productId) async {
    Cart cart = (await loadCartPort.loadCart())..deleteFromCart(productId);
    await deleteFromCartAPIPort?.deleteFromCart(productId);
    updateCartStatePort.updateCartState(cart);
    return Result.success();
  }
}