library shopping_cart;

/// services
export 'package:shopping_cart/application/services/add_to_cart_service.dart';
export 'package:shopping_cart/application/services/remove_from_cart_service.dart';
export 'package:shopping_cart/application/services/delete_from_cart_service.dart';
export 'package:shopping_cart/application/services/get_cart_service.dart';
export 'package:shopping_cart/application/services/empty_cart_service.dart';

/// usecases
export 'package:shopping_cart/application/ports/in/get_cart_usecase.dart';
export 'package:shopping_cart/application/ports/in/empty_cart_usecase.dart';
export 'package:shopping_cart/application/ports/in/add_to_cart_usecase.dart';
export 'package:shopping_cart/application/ports/in/remove_from_cart_usecase.dart';
export 'package:shopping_cart/application/ports/in/delete_from_cart_usecase.dart';

/// persistence
export 'package:shopping_cart/application/ports/out/persistence/load_cart_port.dart';
export 'package:shopping_cart/application/ports/out/persistence/update_cart_state_port.dart';

/// network
export 'package:shopping_cart/application/ports/out/platform/network_check_port.dart';

/// entities
export 'package:shopping_cart/common/entities/failure.dart';
export 'package:shopping_cart/common/entities/base_failure.dart';
export 'package:shopping_cart/common/entities/result.dart';

/// domain
export 'package:shopping_cart/domain/cart.dart';
export 'package:shopping_cart/domain/cart_item.dart';
export 'package:shopping_cart/domain/product.dart';

