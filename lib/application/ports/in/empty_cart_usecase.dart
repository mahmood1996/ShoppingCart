import 'package:shopping_cart/shared_kernels/entities/failure.dart';
import 'package:shopping_cart/shared_kernels/entities/result.dart';

abstract class EmptyCartUseCase {
  Future<Result<Failure, void>> emptyCart();
}