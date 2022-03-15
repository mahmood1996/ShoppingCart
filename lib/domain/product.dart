abstract class Product {
  int    get id;
  double get totalPrice;

  @override
  int get hashCode => Object.hash(id, totalPrice);

  @override
  bool operator ==(Object other) {
    if (other is! Product) return false;
    return id == other.id && totalPrice == other.totalPrice;
  }
}