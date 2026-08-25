# Flutter Shopping App

A responsive bilingual shopping application created for the Flutter shopping
app SRS. The project demonstrates reusable widgets, form validation, animated
navigation, product state, network and asset images, and English/Arabic
localization.

## Features

- Four-field sign-up form with inline validation
- Password visibility controls
- Success dialog followed by a fade page transition
- Responsive product image carousel with a dot indicator
- Two-column product grid
- Add/remove cart behavior with an AppBar counter and SnackBar feedback
- Five-item hot offers list
- English and Arabic localization using Flutter's generated localization API
- Suwannaphum font and both local and online images

## Project structure

```text
first_flutter_project/
├── android/                         # Android platform configuration
├── assets/
│   ├── fonts/                      # Suwannaphum font file
│   └── images/                     # Local product image
├── lib/
│   ├── l10n/
│   │   ├── app_en.arb              # English source translations
│   │   ├── app_ar.arb              # Arabic source translations
│   │   └── app_localizations.dart  # Generated localization API
│   ├── models/
│   │   └── product.dart            # Product data model
│   ├── screens/
│   │   ├── sign_up_page.dart       # Form, validation, dialog, navigation
│   │   └── shopping_screen.dart    # Products, carousel, cart, offers
│   ├── widgets/
│   │   ├── featured_images_section.dart
│   │   ├── hot_offer_tile.dart
│   │   ├── language_button.dart
│   │   ├── product_card.dart
│   │   ├── product_carousel.dart
│   │   ├── product_image.dart
│   │   └── section_title.dart
│   ├── app.dart                    # Theme, locale state, app configuration
│   └── main.dart                   # Application entry point
├── test/
│   └── widget_test.dart            # Validation, navigation, cart, locale tests
├── l10n.yaml                       # Localization generator settings
├── pubspec.yaml                    # Dependencies, assets, and font setup
└── README.md                       # Project documentation
```

## CLI commands used

Create the Flutter project with the required name:

```sh
flutter create first_flutter_project
```

Navigate to the project directory and verify the installed Flutter version:

```sh
cd first_flutter_project
flutter --version
```

Install the dependencies declared in `pubspec.yaml`:

```sh
flutter pub get
```

Generate Dart localization classes from the ARB files:

```sh
flutter gen-l10n
```

List available devices and emulators:

```sh
flutter devices
flutter emulators
```

Start the configured Android emulator and run the app on it:

```sh
flutter emulators --launch Medium_Phone_API_36.1
flutter run -d emulator-5554
```

Run on the currently selected device instead:

```sh
flutter run
```

Format and verify the source code:

```sh
dart format .
flutter analyze
flutter test
```

Build an optimized Android APK:

```sh
flutter build apk --release
```

## Validation rules

- Full Name is required and its first English letter must be uppercase.
- Email is required and must contain `@`.
- Password is required and must contain at least six characters.
- Confirm Password must exactly match Password.

## Localization workflow

Visible application text is stored in `lib/l10n/app_en.arb` and
`lib/l10n/app_ar.arb`. After changing either file, run `flutter gen-l10n`.
The generated `AppLocalizations` class is then used by every screen and widget.

## Assets

The local product photograph comes from Unsplash.
Suwannaphum is distributed by Google Fonts under the SIL Open Font License.
