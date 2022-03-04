import 'package:shopping_cart/domain/cart.dart';
import 'package:shopping_cart/shared_kernels/entities/failure.dart';
import 'package:shopping_cart/shared_kernels/entities/result.dart';

abstract class GetCartUseCase {
  Future<Result<Failure, Cart>> getCart();
}