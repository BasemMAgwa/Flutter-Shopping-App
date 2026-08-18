import 'package:easy_localization/easy_localization.dart';
import 'package:first_flutter_project/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('complete sign-up and localization flow', (tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        saveLocale: false,
        child: const ShoppingApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Check all four inline validation rules.
    await tester.enterText(
      find.byKey(const Key('fullNameField')),
      'john smith',
    );
    await tester.enterText(
      find.byKey(const Key('emailField')),
      'invalid-email',
    );
    await tester.enterText(find.byKey(const Key('passwordField')), '123');
    await tester.enterText(
      find.byKey(const Key('confirmPasswordField')),
      'different',
    );
    await tester.tap(find.byKey(const Key('createAccountButton')));
    await tester.pump();

    expect(find.text('The first letter must be capital'), findsOneWidget);
    expect(find.text('Enter an email containing @'), findsOneWidget);
    expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    expect(find.text('Passwords do not match'), findsOneWidget);

    // Correct the fields and continue to the shopping screen.
    await tester.enterText(
      find.byKey(const Key('fullNameField')),
      'John Smith',
    );
    await tester.enterText(
      find.byKey(const Key('emailField')),
      'john@example.com',
    );
    await tester.enterText(find.byKey(const Key('passwordField')), 'secret1');
    await tester.enterText(
      find.byKey(const Key('confirmPasswordField')),
      'secret1',
    );
    await tester.ensureVisible(find.byKey(const Key('createAccountButton')));
    await tester.tap(find.byKey(const Key('createAccountButton')));
    await tester.pumpAndSettle();

    expect(find.text('Account created successfully'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('Our Products'), findsOneWidget);
    expect(find.text('Hot Offers'), findsOneWidget);
    expect(find.byKey(const Key('productCarouselDots')), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsNothing);
    expect(find.byIcon(Icons.shopping_cart_outlined), findsNothing);

    // Add a product and check the required SnackBar message.
    final addToCartButton = find.byIcon(Icons.add_shopping_cart).first;
    await tester.ensureVisible(addToCartButton);
    await tester.tap(addToCartButton);
    await tester.pump();

    expect(find.text('Item added to the cart'), findsOneWidget);

    // The language button changes the visible shopping labels to Arabic.
    await tester.tap(find.byIcon(Icons.language));
    await tester.pumpAndSettle();

    expect(find.text('منتجاتنا'), findsOneWidget);
  });
}
