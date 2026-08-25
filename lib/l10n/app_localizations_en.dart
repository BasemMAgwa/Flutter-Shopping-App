// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My First Project';

  @override
  String get signUpTitle => 'Sign Up';

  @override
  String get shoppingPageTitle => 'My First Project';

  @override
  String get fullNameLabel => 'Full Name';

  @override
  String get fullNameHint => 'John Smith';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get passwordLabel => 'Password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get showPasswordTooltip => 'Show password';

  @override
  String get hidePasswordTooltip => 'Hide password';

  @override
  String get createAccount => 'Create Account';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get nameCapitalError => 'The first letter must be capital';

  @override
  String get emailError => 'Enter an email containing @';

  @override
  String get passwordLengthError => 'Password must be at least 6 characters';

  @override
  String get passwordMismatchError => 'Passwords do not match';

  @override
  String get accountCreated => 'Account created successfully';

  @override
  String get continueButton => 'Continue';

  @override
  String get ourProducts => 'Our Products';

  @override
  String get hotOffers => 'Hot Offers';

  @override
  String get imagesDisplayed => 'The two images are displayed';

  @override
  String get addToCartTooltip => 'Add to cart';

  @override
  String get removeFromCartTooltip => 'Remove from cart';

  @override
  String get itemAddedToCart => 'Item added to the cart';

  @override
  String get itemRemovedFromCart => 'Item removed from the cart';

  @override
  String get cartTooltip => 'Shopping cart';

  @override
  String get changeLanguageTooltip => 'Change language';

  @override
  String get productHeadphones => 'Wireless Headphones';

  @override
  String get productShoes => 'Running Shoes';

  @override
  String get productWatch => 'Smart Watch';

  @override
  String get productBackpack => 'Travel Backpack';

  @override
  String get productCamera => 'Digital Camera';

  @override
  String productPrice(String price) {
    return '\$$price';
  }

  @override
  String hotOfferName(String product) {
    return 'Special offer: $product';
  }

  @override
  String get hotOfferDescription => 'Limited-time price on this popular item.';

  @override
  String get imageLoadError => 'Image unavailable';
}
