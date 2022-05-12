import 'package:shopping_cart/shopping_cart.dart';

class RemoveFromCartService implements RemoveFromCartUseCase {
  final RemoveFromCartAPIPort removeFromCartAPIPort;
  final LoadCartPort loadCartPort;
  final UpdateCartStatePort updateCartStatePort;
  final NetworkCheckPort networkCheckPort;
  final CartChangeListenerPort cartChangeListenerPort;

  RemoveFromCartService({
    required this.removeFromCartAPIPort,
    required this.loadCartPort,
    required this.networkCheckPort,
    required this.updateCartStatePort,
    required this.cartChangeListenerPort,
  });

  @override
  Future<Result<Failure, void>> removeFromCart(int productId) async {
    if (!await networkCheckPort.isConnected!) {
      return Result.failure(BaseFailure(type: FailureType.network));
    }
    return await _removeFromCart(productId);
  }

  Future<Result<Failure, void>> _removeFromCart(int productId) async {
    await removeFromCartAPIPort.removeFromCart(productId);
    Cart cart = await loadCartPort.loadCart()!
      ..removeFromCart(productId);
    updateCartStatePort.updateCartState(cart);
    cartChangeListenerPort.listen(cart);
    return Result.success();
  }
}
