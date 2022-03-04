import 'package:shopping_cart/shared_kernels/entities/failure.dart';
import 'package:shopping_cart/shared_kernels/entities/result.dart';

abstract class RemoveFromCartUseCase {
  Future<Result<Failure, void>> removeFromCart(int productId);
}
