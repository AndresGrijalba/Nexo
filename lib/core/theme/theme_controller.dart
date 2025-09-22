// core/theme/theme_controller.dart
import 'package:flutter/material.dart';

class ThemeController {
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);
  static final ValueNotifier<Color> colorNotifier = ValueNotifier(const Color(0xFF1dd4d2));

  static void toggleTheme() {
    final currentMode = themeNotifier.value;
    final bool isDrawerOpen = scaffoldKey.currentState?.isDrawerOpen ?? false;

    if (isDrawerOpen) {
      scaffoldKey.currentState?.closeDrawer();
      Future.delayed(const Duration(milliseconds: 200), () {
        themeNotifier.value = currentMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      });
    } else {
      themeNotifier.value = currentMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    }
  }
}