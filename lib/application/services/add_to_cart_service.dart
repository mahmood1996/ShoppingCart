import 'package:shopping_cart/application/ports/out/change_listener/cart_change_listener_port.dart';
import 'package:shopping_cart/shopping_cart.dart';

class AddToCartService implements AddToCartUseCase {
  final NetworkCheckPort networkCheckPort;
  final LoadCartPort loadCartPort;
  final UpdateCartStatePort updateCartStatePort;
  final AddToCartAPIPort addToCartAPIPort;
  final CartChangeListenerPort cartChangeListenerPort;

  AddToCartService({
    required this.networkCheckPort,
    required this.loadCartPort,
    required this.updateCartStatePort,
    required this.addToCartAPIPort,
    required this.cartChangeListenerPort,
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
    await addToCartAPIPort.addToCart(product);
    Cart cart = (await loadCartPort.loadCart())!..addToCart(product);
    await updateCartStatePort.updateCartState(cart);
    cartChangeListenerPort.listen(cart);
    return Result.success();
  }
}
