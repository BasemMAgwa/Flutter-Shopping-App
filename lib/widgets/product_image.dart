import 'package:flutter/material.dart';

/// Loads a network product image with progress and failure placeholders.
class ProductImage extends StatelessWidget {
  const ProductImage({
    required this.imageUrl,
    required this.errorMessage,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    super.key,
  });

  final String imageUrl;
  final String errorMessage;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          // Flutter returns the completed image once progress becomes null.
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          // A localized fallback keeps failed requests understandable.
          return ColoredBox(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.broken_image_outlined),
                    const SizedBox(height: 4),
                    Text(errorMessage, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
