import 'package:flutter/material.dart';

import '../models/product.dart';
import 'product_image.dart';

/// Presents a product and exposes one button for adding or removing it.
class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.formattedPrice,
    required this.addToCartTooltip,
    required this.removeFromCartTooltip,
    required this.errorMessage,
    required this.isInCart,
    required this.onCartPressed,
    super.key,
  });

  /// Product data displayed by this card.
  final Product product;

  /// Price after locale-specific formatting has been applied.
  final String formattedPrice;
  final String addToCartTooltip;
  final String removeFromCartTooltip;
  final String errorMessage;

  /// Selects the add or remove icon and its matching tooltip.
  final bool isInCart;

  /// Delegates the cart state change to the parent shopping screen.
  final VoidCallback onCartPressed;

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
                  tooltip: isInCart ? removeFromCartTooltip : addToCartTooltip,
                  visualDensity: VisualDensity.compact,
                  onPressed: onCartPressed,
                  icon: Icon(
                    isInCart
                        ? Icons.remove_shopping_cart
                        : Icons.add_shopping_cart,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
