import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController {
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);
  static final ValueNotifier<Color> colorNotifier = ValueNotifier(const Color(0xFF1DD4D2));

  static const _kThemeMode = 'themeMode';
  static const _kSeedColor = 'seedColor';

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    final modeIndex = prefs.getInt(_kThemeMode);
    if (modeIndex != null && modeIndex >= 0 && modeIndex < ThemeMode.values.length) {
      themeNotifier.value = ThemeMode.values[modeIndex];
    }

    final colorValue = prefs.getInt(_kSeedColor);
    if (colorValue != null) {
      colorNotifier.value = Color(colorValue);
    }

    themeNotifier.addListener(() async {
      await prefs.setInt(_kThemeMode, themeNotifier.value.index);
    });

    colorNotifier.addListener(() async {
      await prefs.setInt(_kSeedColor, colorNotifier.value.toARGB32());
    });
  }

  static void toggleTheme() {
    final currentMode = themeNotifier.value;
    final isDrawerOpen = scaffoldKey.currentState?.isDrawerOpen ?? false;
    final next = (currentMode == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;

    if (isDrawerOpen) {
      scaffoldKey.currentState?.closeDrawer();
      Future.delayed(const Duration(milliseconds: 200), () {
        themeNotifier.value = next;
      });
    } else {
      themeNotifier.value = next;
    }
  }

  static void setThemeMode(ThemeMode mode) {
    themeNotifier.value = mode;
  }

  static void setSeedColor(Color color) {
    colorNotifier.value = color;
  }
}
