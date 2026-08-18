import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'screens/sign_up_page.dart';

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => context.tr('appTitle'),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Suwannaphum-Regular',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00695C)),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
        ),
      ),
      home: const SignUpPage(),
    );
  }
}
