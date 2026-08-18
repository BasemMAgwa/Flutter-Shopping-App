import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: context.tr('changeLanguageTooltip'),
      icon: const Icon(Icons.language),
      onPressed: () {
        final isArabic = context.locale.languageCode == 'ar';
        context.setLocale(Locale(isArabic ? 'en' : 'ar'));
      },
    );
  }
}
