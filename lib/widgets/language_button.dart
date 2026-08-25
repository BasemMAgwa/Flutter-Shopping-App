import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

/// Displays a reusable action that toggles between English and Arabic.
class LanguageButton extends StatelessWidget {
  const LanguageButton({required this.onLocaleChanged, super.key});

  /// Sends the newly selected locale back to the application widget.
  final ValueChanged<Locale> onLocaleChanged;

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);
    final localizations = AppLocalizations.of(context)!;

    return IconButton(
      tooltip: localizations.changeLanguageTooltip,
      icon: const Icon(Icons.language),
      onPressed: () {
        final nextLanguage = currentLocale.languageCode == 'ar' ? 'en' : 'ar';
        onLocaleChanged(Locale(nextLanguage));
      },
    );
  }
}
