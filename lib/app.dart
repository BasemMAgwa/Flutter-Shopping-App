import 'package:flutter/material.dart';

import 'l10n/app_localizations.dart';
import 'screens/sign_up_page.dart';

/// Configures the application theme, localization, and first screen.
///
/// Locale state lives here so both screens can switch between English and
/// Arabic without using an additional state-management package.
class ShoppingApp extends StatefulWidget {
  const ShoppingApp({super.key, this.initialLocale});

  /// Allows widget tests to start in a predictable language.
  final Locale? initialLocale;

  @override
  State<ShoppingApp> createState() => _ShoppingAppState();
}

class _ShoppingAppState extends State<ShoppingApp> {
  Locale? _selectedLocale;

  @override
  void initState() {
    super.initState();
    _selectedLocale = widget.initialLocale;
  }

  /// Rebuilds [MaterialApp] with the language selected by the user.
  void _changeLocale(Locale locale) {
    setState(() => _selectedLocale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      locale: _selectedLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Suwannaphum-Regular',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00695C)),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
        ),
      ),
      home: SignUpPage(onLocaleChanged: _changeLocale),
    );
  }
}
