import 'package:shopping_cart/shopping_cart.dart';

class GetCartAdapter {
  final GetCartUseCase getCartUseCase;
  GetCartAdapter({required this.getCartUseCase});

  Future<Result<Failure, Cart>> getCart() async {
    return await getCartUseCase.getCart();
  }
}