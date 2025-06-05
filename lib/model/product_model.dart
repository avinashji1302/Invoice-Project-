class ProductModel {
  final String name;
  final double price;
  bool isSelected;

  ProductModel({
    required this.name,
    required this.price,
    this.isSelected = false,
  });
}
