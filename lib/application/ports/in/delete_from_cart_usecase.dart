import 'package:shopping_cart/common/entities/failure.dart';
import 'package:shopping_cart/common/entities/result.dart';

abstract class DeleteFromCartUseCase {
  Future<Result<Failure, void>> deleteFromCart(int productId);
}