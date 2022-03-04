import '../../../domain/product.dart';
import '../../../shared_kernels/entities/failure.dart';
import '../../../shared_kernels/entities/result.dart';

abstract class AddToCartUseCase {
  Future<Result<Failure, void>> addToCart(Product product);
}