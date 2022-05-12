import 'package:shopping_cart/shopping_cart.dart';

class AddToCartAdapter {
  final AddToCartUseCase addToCartUseCase;
  AddToCartAdapter({required this.addToCartUseCase});

  Future<Result<Failure, void>> addToCart(Product product) async {
    return await addToCartUseCase.addToCart(product);
  }
}