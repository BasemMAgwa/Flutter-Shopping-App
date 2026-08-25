import 'package:flutter/material.dart';

import '../models/product.dart';
import 'product_image.dart';

/// Displays product images one page at a time and reports page changes.
class ProductCarousel extends StatelessWidget {
  const ProductCarousel({
    required this.products,
    required this.errorMessage,
    required this.onPageChanged,
    super.key,
  });

  /// Products whose images become individual pages.
  final List<Product> products;

  /// Localized fallback displayed for failed images.
  final String errorMessage;

  /// Notifies the shopping screen so it can update the active dot.
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: products.length,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        final product = products[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: ProductImage(
            imageUrl: product.imageUrl,
            errorMessage: errorMessage,
          ),
        );
      },
    );
  }
}
