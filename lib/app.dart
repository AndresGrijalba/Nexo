import 'package:flutter/material.dart';
import 'package:nexo/routes.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        ThemeController.themeNotifier,
        ThemeController.colorNotifier,
      ]),
      builder: (context, _) {
        final themeMode = ThemeController.themeNotifier.value;
        final mainColor = ThemeController.colorNotifier.value;

        return MaterialApp(
          title: 'Nexo',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: AppTheme.light(mainColor),
          darkTheme: AppTheme.dark(mainColor),
          routes: AppRoutes.routes,
          initialRoute: AppRoutes.root,
        );
      },
    );
  }
}
