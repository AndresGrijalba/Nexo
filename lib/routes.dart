import 'package:flutter/material.dart';
import 'package:nexo/features/web/screens/aulaweb_screen.dart';

import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/register_screen.dart';
import 'features/auth/wrapper/auth_wrapper.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/settings/screens/colortheme_screen.dart';
import 'features/settings/screens/settings_screen.dart';
import 'features/task/screens/task_screen.dart';
import 'features/web/screens/web_screen.dart';

class AppRoutes {
  static const String root = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String web = '/web';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String theme = '/theme';
  static const String aulaweb = '/aulaweb';

  static Map<String, WidgetBuilder> routes = {
    root: (context) => const AuthWrapper(),
    login: (context) => const LoginScreen(),
    register: (context) => RegisterScreen(),
    home: (context) => TaskScreen(),
    web: (context) => WebViewPage(),
    profile: (context) => ProfileScreen(),
    settings: (context) => SettingsScreen(),
    theme: (context) => ColorThemeScreen(),
    aulaweb: (context) => AulaWebViewPage(),
  };
}
