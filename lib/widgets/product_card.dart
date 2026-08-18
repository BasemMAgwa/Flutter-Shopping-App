import 'package:flutter/material.dart';

import '../models/product.dart';
import 'product_image.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.formattedPrice,
    required this.addToCartTooltip,
    required this.errorMessage,
    required this.onAddToCart,
    super.key,
  });

  final Product product;
  final String formattedPrice;
  final String addToCartTooltip;
  final String errorMessage;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ProductImage(
                imageUrl: product.imageUrl,
                errorMessage: errorMessage,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    formattedPrice,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: addToCartTooltip,
                  visualDensity: VisualDensity.compact,
                  onPressed: onAddToCart,
                  icon: const Icon(Icons.add_shopping_cart),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
