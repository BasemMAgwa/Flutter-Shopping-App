/// Holds the information needed to render a product throughout the app.
class Product {
  const Product({
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  /// Localized name displayed on product cards and offer tiles.
  final String name;

  /// Numeric value formatted by the active localization before display.
  final double price;

  /// Remote image shared by all widgets that represent this product.
  final String imageUrl;
}
