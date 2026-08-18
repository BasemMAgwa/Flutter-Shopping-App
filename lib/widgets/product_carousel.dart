import 'package:flutter/material.dart';

import '../models/product.dart';
import 'product_image.dart';

class ProductCarousel extends StatelessWidget {
  const ProductCarousel({
    required this.products,
    required this.errorMessage,
    required this.onPageChanged,
    super.key,
  });

  final List<Product> products;
  final String errorMessage;
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
