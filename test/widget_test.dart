import 'package:first_flutter_project/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Creates a predictable English app for every widget test assertion.
  Widget buildTestApp() {
    return const ShoppingApp(initialLocale: Locale('en'));
  }

  testWidgets('validates sign-up and supports the complete shopping flow', (
    tester,
  ) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    // Submit invalid values to verify all four inline validation messages.
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
    await tester.ensureVisible(find.byKey(const Key('createAccountButton')));
    await tester.tap(find.byKey(const Key('createAccountButton')));
    await tester.pump();

    expect(find.text('The first letter must be capital'), findsOneWidget);
    expect(find.text('Enter an email containing @'), findsOneWidget);
    expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    expect(find.text('Passwords do not match'), findsOneWidget);

    // Correct every value and confirm navigation through the success dialog.
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
    expect(find.byKey(const Key('productCarouselDots')), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsNothing);

    // The first press adds the product and increases the badge from zero to one.
    final cartBadge = find.byKey(const Key('cartBadge'));
    expect(
      find.descendant(of: cartBadge, matching: find.text('0')),
      findsOneWidget,
    );

    final addButton = find.byIcon(Icons.add_shopping_cart).first;
    await tester.ensureVisible(addButton);
    await tester.tap(addButton);
    await tester.pump();

    expect(find.text('Item added to the cart'), findsOneWidget);
    expect(
      find.descendant(of: cartBadge, matching: find.text('1')),
      findsOneWidget,
    );

    // Pressing the same product button removes it and restores a zero count.
    final removeButton = find.byIcon(Icons.remove_shopping_cart).first;
    await tester.tap(removeButton);
    await tester.pump();

    expect(find.text('Item removed from the cart'), findsOneWidget);
    expect(
      find.descendant(of: cartBadge, matching: find.text('0')),
      findsOneWidget,
    );

    // The language action rebuilds every generated localized string in Arabic.
    await tester.tap(find.byIcon(Icons.language));
    await tester.pumpAndSettle();

    expect(find.text('منتجاتنا'), findsOneWidget);
  });
}
