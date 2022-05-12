import 'package:shopping_cart/shopping_cart.dart';

class EmptyCartService implements EmptyCartUseCase {
  final EmptyCartAPIPort emptyCartAPIPort;
  final NetworkCheckPort networkCheckPort;
  final UpdateCartStatePort updateCartStatePort;
  final CartChangeListenerPort cartChangeListenerPort;

  EmptyCartService({
    required this.emptyCartAPIPort,
    required this.networkCheckPort,
    required this.updateCartStatePort,
    required this.cartChangeListenerPort,
  });

  @override
  Future<Result<Failure, void>> emptyCart() async {
    if (! await networkCheckPort.isConnected!) {
      return Result.failure(BaseFailure(type: FailureType.network));
    }
    return await _emptyCart();
  }

  Future<Result<Failure, void>> _emptyCart() async {
    await emptyCartAPIPort.emptyCart();
    updateCartStatePort.updateCartState(Cart());
    cartChangeListenerPort.listen(Cart());
    return Result.success();
  }
}