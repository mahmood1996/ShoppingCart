import 'package:shopping_cart/common/entities/failure.dart';
import 'package:shopping_cart/common/entities/result.dart';

abstract class EmptyCartUseCase {
  Future<Result<Failure, void>> emptyCart();
}