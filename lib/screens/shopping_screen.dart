import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/product.dart';
import '../widgets/featured_images_section.dart';
import '../widgets/hot_offer_tile.dart';
import '../widgets/language_button.dart';
import '../widgets/product_card.dart';
import '../widgets/product_carousel.dart';
import '../widgets/section_title.dart';

/// Shows the responsive product catalog, carousel, cart state, and hot offers.
class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({required this.onLocaleChanged, super.key});

  /// Updates the locale stored by the root application widget.
  final ValueChanged<Locale> onLocaleChanged;

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  // The selected carousel page controls the active dot indicator.
  int _currentCarouselPage = 0;

  // A set prevents the same product from being counted more than once.
  final Set<int> _cartProductIndexes = <int>{};

  // Images are shared by the carousel, product grid, and offers list.
  final List<String> _imageUrls = const [
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30',
    'https://images.unsplash.com/photo-1553062407-98eeb64c6a62',
    'https://images.unsplash.com/photo-1516035069371-29a1b244cc32',
  ];

  /// Builds localized products again whenever the selected language changes.
  List<Product> _createProducts(AppLocalizations localizations) {
    return [
      Product(
        name: localizations.productHeadphones,
        price: 79.99,
        imageUrl: _imageUrls[0],
      ),
      Product(
        name: localizations.productShoes,
        price: 64.50,
        imageUrl: _imageUrls[1],
      ),
      Product(
        name: localizations.productWatch,
        price: 119.00,
        imageUrl: _imageUrls[2],
      ),
      Product(
        name: localizations.productBackpack,
        price: 49.99,
        imageUrl: _imageUrls[3],
      ),
      Product(
        name: localizations.productCamera,
        price: 249.00,
        imageUrl: _imageUrls[4],
      ),
    ];
  }

  /// Adds a new product or removes it when the same button is pressed again.
  void _toggleCart(int productIndex, AppLocalizations localizations) {
    final isRemoving = _cartProductIndexes.contains(productIndex);

    setState(() {
      if (isRemoving) {
        _cartProductIndexes.remove(productIndex);
      } else {
        _cartProductIndexes.add(productIndex);
      }
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            isRemoving
                ? localizations.itemRemovedFromCart
                : localizations.itemAddedToCart,
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final products = _createProducts(localizations);
    final screenSize = MediaQuery.of(context).size;
    final horizontalPadding = screenSize.width > 800 ? 80.0 : 16.0;
    final carouselHeight = screenSize.width < 400 ? 180.0 : 220.0;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(localizations.shoppingPageTitle),
        actions: [
          Center(
            child: Tooltip(
              message: localizations.cartTooltip,
              child: Badge(
                key: const Key('cartBadge'),
                label: Text(_cartProductIndexes.length.toString()),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ),
          const SizedBox(width: 12),
          LanguageButton(onLocaleChanged: widget.onLocaleChanged),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            16,
            horizontalPadding,
            24,
          ),
          child: Column(
            children: [
              const FeaturedImagesSection(),
              const SizedBox(height: 28),
              SectionTitle(localizations.ourProducts),
              const SizedBox(height: 12),
              SizedBox(
                height: carouselHeight,
                child: ProductCarousel(
                  products: products,
                  errorMessage: localizations.imageLoadError,
                  onPageChanged: (page) {
                    setState(() => _currentCarouselPage = page);
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                key: const Key('productCarouselDots'),
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(products.length, (index) {
                  final isSelected = index == _currentCarouselPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isSelected ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: screenSize.width < 380 ? 0.66 : 0.78,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    product: product,
                    formattedPrice: localizations.productPrice(
                      product.price.toStringAsFixed(2),
                    ),
                    addToCartTooltip: localizations.addToCartTooltip,
                    removeFromCartTooltip: localizations.removeFromCartTooltip,
                    errorMessage: localizations.imageLoadError,
                    isInCart: _cartProductIndexes.contains(index),
                    onCartPressed: () => _toggleCart(index, localizations),
                  );
                },
              ),
              const SizedBox(height: 28),
              SectionTitle(localizations.hotOffers),
              const SizedBox(height: 12),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return HotOfferTile(
                    product: product,
                    title: localizations.hotOfferName(product.name),
                    description: localizations.hotOfferDescription,
                    errorMessage: localizations.imageLoadError,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
