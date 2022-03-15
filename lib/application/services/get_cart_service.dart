import 'package:shopping_cart/application/ports/in/get_cart_usecase.dart';
import 'package:shopping_cart/application/ports/out/api/get_cart_api_port.dart';
import 'package:shopping_cart/application/ports/out/persistence/update_cart_state_port.dart';
import 'package:shopping_cart/application/ports/out/platform/network_check_port.dart';
import 'package:shopping_cart/domain/cart.dart';
import 'package:shopping_cart/common/entities/base_failure.dart';
import 'package:shopping_cart/common/entities/failure.dart';
import 'package:shopping_cart/common/entities/result.dart';

class GetCartService implements GetCartUseCase {
  final UpdateCartStatePort updateCartStatePort;
  final NetworkCheckPort networkCheckPort;
  final GetCartAPIPort getCartAPIPort;

  GetCartService(
      {required this.getCartAPIPort,
      required this.networkCheckPort,
      required this.updateCartStatePort});

  @override
  Future<Result<Failure, Cart>> getCart() async {
    if (!await networkCheckPort.isConnected) {
      return Result.failure(BaseFailure(type: FailureType.network));
    }

    return await _getCart();
  }

  Future<Result<Failure, Cart>> _getCart() async {
    Cart cart = await getCartAPIPort.getCart();
    await updateCartStatePort.updateCartState(cart);
    return Result.success(cart);
  }
}
