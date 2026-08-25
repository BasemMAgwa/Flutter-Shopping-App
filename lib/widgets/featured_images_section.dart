import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import 'product_image.dart';

/// Implements the first SRS phase with one asset and one network image.
class FeaturedImagesSection extends StatelessWidget {
  const FeaturedImagesSection({super.key});

  // This URL supplies the online image required alongside the asset image.
  static const _onlineImageUrl =
      'https://images.unsplash.com/photo-1523275335684-37898b6baf30'
      '?auto=format&fit=crop&w=900&q=80';

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

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
                        Center(child: Text(localizations.imageLoadError)),
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
                  errorMessage: localizations.imageLoadError,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          localizations.imagesDisplayed,
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
