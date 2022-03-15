import 'package:shopping_cart/application/ports/in/get_cart_from_cache_usecase.dart';
import 'package:shopping_cart/application/ports/out/persistence/load_cart_port.dart';
import 'package:shopping_cart/domain/cart.dart';

class GetCartFromCacheService implements GetCartFromCacheUseCase {
  final LoadCartPort loadCartPort;
  GetCartFromCacheService({required this.loadCartPort});

  @override
  Future<Cart> getCart() async {
    return await loadCartPort.loadCart();
  }
}