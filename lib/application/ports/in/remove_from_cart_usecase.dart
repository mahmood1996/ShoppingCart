import 'package:shopping_cart/common/entities/failure.dart';
import 'package:shopping_cart/common/entities/result.dart';

abstract class RemoveFromCartUseCase {
  Future<Result<Failure, void>> removeFromCart(int productId);
}
