import 'package:shopping_cart/shopping_cart.dart';

class RemoveFromCartAdapter {
  final RemoveFromCartUseCase removeFromCartUseCase;
  RemoveFromCartAdapter({required this.removeFromCartUseCase});

  Future<Result<Failure, void>> removeFromCart(int productId) async {
    return await removeFromCartUseCase.removeFromCart(productId);
  }
}