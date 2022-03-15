import 'package:shopping_cart/common/entities/failure.dart';

enum FailureType {network, server, other}

class BaseFailure extends Failure {
  final FailureType type;
  BaseFailure({required this.type});

  @override
  bool operator ==(Object other) {
    if (other is! BaseFailure) return false;
    return type == other.type;
  }
}