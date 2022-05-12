import 'package:shopping_cart/shopping_cart.dart';

class DeleteFromCartAdapter {
  final DeleteFromCartUseCase deleteFromCartUseCase;
  DeleteFromCartAdapter({required this.deleteFromCartUseCase});

  Future<Result<Failure, void>> deleteFromCart(int productId) async {
    return await deleteFromCartUseCase.deleteFromCart(productId);
  }
}