class Product {
  final int id;
  final double totalPrice;

  const Product({
    required this.id,
    required this.totalPrice,
  });

  @override
  int get hashCode => Object.hash(id, totalPrice);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Product) return false;
    return id == other.id && totalPrice == other.totalPrice;
  }
}