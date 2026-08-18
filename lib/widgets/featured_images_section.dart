import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'product_image.dart';

class FeaturedImagesSection extends StatelessWidget {
  const FeaturedImagesSection({super.key});

  static const _onlineImageUrl =
      'https://images.unsplash.com/photo-1523275335684-37898b6baf30'
      '?auto=format&fit=crop&w=900&q=80';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/local_product.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Center(child: Text(context.tr('imageLoadError'))),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.25,
                child: ProductImage(
                  imageUrl: _onlineImageUrl,
                  errorMessage: context.tr('imageLoadError'),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          context.tr('imagesDisplayed'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Suwannaphum-Regular',
            fontSize: 18,
            color: Color(0xFF00695C),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
