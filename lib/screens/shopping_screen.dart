import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/featured_images_section.dart';
import '../widgets/hot_offer_tile.dart';
import '../widgets/language_button.dart';
import '../widgets/product_card.dart';
import '../widgets/product_carousel.dart';
import '../widgets/section_title.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  int _currentCarouselPage = 0;

  final List<String> _imageUrls = const [
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30',
    'https://images.unsplash.com/photo-1553062407-98eeb64c6a62',
    'https://images.unsplash.com/photo-1516035069371-29a1b244cc32',
  ];

  List<Product> _createProducts() {
    // Product names are rebuilt when the user changes the language.
    return [
      Product(
        name: context.tr('productHeadphones'),
        price: 79.99,
        imageUrl: _imageUrls[0],
      ),
      Product(
        name: context.tr('productShoes'),
        price: 64.50,
        imageUrl: _imageUrls[1],
      ),
      Product(
        name: context.tr('productWatch'),
        price: 119.00,
        imageUrl: _imageUrls[2],
      ),
      Product(
        name: context.tr('productBackpack'),
        price: 49.99,
        imageUrl: _imageUrls[3],
      ),
      Product(
        name: context.tr('productCamera'),
        price: 249.00,
        imageUrl: _imageUrls[4],
      ),
    ];
  }

  void _addToCart() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(context.tr('itemAddedToCart'))));
  }

  @override
  Widget build(BuildContext context) {
    final products = _createProducts();
    final screenSize = MediaQuery.of(context).size;
    final horizontalPadding = screenSize.width > 800 ? 80.0 : 16.0;
    final carouselHeight = screenSize.width < 400 ? 180.0 : 220.0;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(context.tr('shoppingPageTitle')),
        actions: const [LanguageButton()],
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
              SectionTitle(context.tr('ourProducts')),
              const SizedBox(height: 12),
              SizedBox(
                height: carouselHeight,
                child: ProductCarousel(
                  products: products,
                  errorMessage: context.tr('imageLoadError'),
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
                    formattedPrice: context.tr(
                      'productPrice',
                      namedArgs: {'price': product.price.toStringAsFixed(2)},
                    ),
                    addToCartTooltip: context.tr('addToCartTooltip'),
                    errorMessage: context.tr('imageLoadError'),
                    onAddToCart: _addToCart,
                  );
                },
              ),
              const SizedBox(height: 28),
              SectionTitle(context.tr('hotOffers')),
              const SizedBox(height: 12),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return HotOfferTile(
                    product: product,
                    title: context.tr(
                      'hotOfferName',
                      namedArgs: {'product': product.name},
                    ),
                    description: context.tr('hotOfferDescription'),
                    errorMessage: context.tr('imageLoadError'),
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
