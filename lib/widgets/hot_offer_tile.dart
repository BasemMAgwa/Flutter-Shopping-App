import 'package:flutter/material.dart';

import '../models/product.dart';
import 'product_image.dart';

class HotOfferTile extends StatelessWidget {
  const HotOfferTile({
    required this.product,
    required this.title,
    required this.description,
    required this.errorMessage,
    super.key,
  });

  final Product product;
  final String title;
  final String description;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ProductImage(
                  imageUrl: product.imageUrl,
                  errorMessage: errorMessage,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
