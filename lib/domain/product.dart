class Product {
  final int id;
  final double price;

  const Product({
    required this.id,
    required this.price,
  });

  @override
  int get hashCode => Object.hash(id, price);

  @override
  bool operator ==(Object other) {
    if (other is! Product) return false;
    return id == other.id && price == other.price;
  }
}