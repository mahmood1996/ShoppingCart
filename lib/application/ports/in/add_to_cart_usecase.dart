import '../../../domain/product.dart';
import '../../../common/entities/failure.dart';
import '../../../common/entities/result.dart';

abstract class AddToCartUseCase {
  Future<Result<Failure, void>> addToCart(Product product);
}