import 'package:shopping_cart/domain/cart.dart';
import 'package:shopping_cart/common/entities/failure.dart';
import 'package:shopping_cart/common/entities/result.dart';

abstract class GetCartUseCase {
  Future<Result<Failure, Cart>> getCart();
}