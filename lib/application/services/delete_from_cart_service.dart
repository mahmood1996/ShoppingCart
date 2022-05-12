import 'package:shopping_cart/shopping_cart.dart';

class DeleteFromCartService implements DeleteFromCartUseCase {
  final LoadCartPort loadCartPort;
  final DeleteFromCartAPIPort deleteFromCartAPIPort;
  final UpdateCartStatePort updateCartStatePort;
  final NetworkCheckPort networkCheckPort;
  final CartChangeListenerPort cartChangeListenerPort;

  DeleteFromCartService({
    required this.loadCartPort,
    required this.networkCheckPort,
    required this.updateCartStatePort,
    required this.deleteFromCartAPIPort,
    required this.cartChangeListenerPort,
  });

  @override
  Future<Result<Failure, void>> deleteFromCart(int productId) async {
    if (! await networkCheckPort.isConnected!){
      return Result.failure(BaseFailure(type: FailureType.network));
    }
    return await _deleteFromCart(productId);
  }

  Future<Result<Failure, void>> _deleteFromCart(int productId) async {
    await deleteFromCartAPIPort.deleteFromCart(productId);
    Cart cart = (await loadCartPort.loadCart()!)..deleteFromCart(productId);
    await updateCartStatePort.updateCartState(cart);
    cartChangeListenerPort.listen(cart);
    return Result.success();
  }
}