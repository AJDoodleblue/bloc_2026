import 'package:bloc_2026/core/constants/app_language.dart';
import 'package:bloc_2026/routes/app_routes.dart';
import 'package:bloc_2026/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languageConfig});

  final Map<String, Map<String, String>> languageConfig;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: 'Bloc 2026',
      theme: AppTheme.lightTheme,
      translations: AppTranslations(languageConfig),
      locale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }
}
