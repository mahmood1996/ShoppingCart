import 'package:shopping_cart/application/ports/in/empty_cart_usecase.dart';
import 'package:shopping_cart/application/ports/out/api/empty_cart_api_port.dart';
import 'package:shopping_cart/application/ports/out/persistence/update_cart_state_port.dart';
import 'package:shopping_cart/application/ports/out/platform/network_check_port.dart';
import 'package:shopping_cart/domain/cart.dart';
import 'package:shopping_cart/shared_kernels/entities/base_failure.dart';
import 'package:shopping_cart/shared_kernels/entities/failure.dart';
import 'package:shopping_cart/shared_kernels/entities/result.dart';

class EmptyCartService implements EmptyCartUseCase {
  final EmptyCartAPIPort? emptyCartAPIPort;
  final NetworkCheckPort networkCheckPort;
  final UpdateCartStatePort updateCartStatePort;

  EmptyCartService({
    this.emptyCartAPIPort,
    required this.networkCheckPort,
    required this.updateCartStatePort,
  });

  @override
  Future<Result<Failure, void>> emptyCart() async {
    if (! await networkCheckPort.isConnected) {
      return Result.failure(BaseFailure(type: FailureType.network));
    }
    return await _emptyCart();
  }

  Future<Result<Failure, void>> _emptyCart() async {
    await emptyCartAPIPort?.emptyCart();
    updateCartStatePort.updateCartState(Cart());
    return Result.success();
  }
}