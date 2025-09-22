import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nexo/core/theme/theme_controller.dart';
import 'package:nexo/features/profile/screens/profile_screen.dart';
import 'package:nexo/features/settings/screens/settings_screen.dart';
import '../../features/web/screens/aulaweb_screen.dart';
import '../../features/web/screens/web_screen.dart';

class DrawerScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final String currentRoute;
  final FloatingActionButton? floatingActionButton;

  const DrawerScaffold({
    super.key,
    required this.title,
    required this.body,
    required this.currentRoute,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'NEXO',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Andres Grijalba',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '✈️',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Versión 1.0.1',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                        ValueListenableBuilder<ThemeMode>(
                          valueListenable: ThemeController.themeNotifier,
                          builder: (context, mode, _) {
                            final isDark = Theme.of(context).brightness == Brightness.dark;

                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                ThemeController.themeNotifier.value =
                                isDark ? ThemeMode.light : ThemeMode.dark;
                              },
                              child: Transform.translate(
                                offset: const Offset(-8, 0),
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 400),
                                  transitionBuilder: (child, anim) {
                                    return RotationTransition(
                                      turns: child.key == const ValueKey('sun')
                                          ? Tween<double>(begin: 0.75, end: 1).animate(anim)
                                          : Tween<double>(begin: 1.25, end: 1).animate(anim),
                                      child: FadeTransition(opacity: anim, child: child),
                                    );
                                  },
                                  child: Icon(
                                    isDark ? Icons.nightlight_round : Icons.wb_sunny,
                                    key: ValueKey(isDark ? 'moon' : 'sun'),
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_outlined, color: Theme.of(context).colorScheme.primary),
                    title: Text(
                      'Perfil',
                      style: TextStyle(
                        color: currentRoute == '/profile'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: currentRoute == '/profile' ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: currentRoute == '/profile',
                    onTap: () {
                      if (currentRoute != '/profile') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ProfileScreen()),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  Divider(
                    color: Colors.black.withAlpha(55),
                    thickness: 2,
                  ),
                  ListTile(
                    leading: Icon(EvaIcons.calendarOutline, color: Theme.of(context).colorScheme.primary),
                    title: Text(
                      'Agenda de tareas',
                      style: TextStyle(
                        color: currentRoute == '/agenda'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: currentRoute == '/agenda' ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: currentRoute == '/agenda',
                    onTap: () {
                      if (currentRoute != '/agenda') {
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(EvaIcons.clockOutline, color: Theme.of(context).colorScheme.primary),
                    title: Text(
                      'Horario',
                      style: TextStyle(
                        color: currentRoute == '/horario'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: currentRoute == '/horario' ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: currentRoute == '/horario',
                    onTap: () {
                      if (currentRoute != '/horario') {
                        // Lógica de navegación a la pantalla de horario
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.calculate_outlined, color: Theme.of(context).colorScheme.primary),
                    title: Text(
                      'Definitiva',
                      style: TextStyle(
                        color: currentRoute == '/definitiva'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: currentRoute == '/definitiva' ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: currentRoute == '/definitiva',
                    onTap: () {
                      if (currentRoute != '/definitiva') {
                        // Lógica de navegación a la pantalla de definitiva
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.account_tree_outlined, color: Theme.of(context).colorScheme.primary),
                    title: Text(
                      'Semaforo',
                      style: TextStyle(
                        color: currentRoute == '/materias'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: currentRoute == '/materias' ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: currentRoute == '/materias',
                    onTap: () {
                      if (currentRoute != '/materias') {
                        // Lógica de navegación a la pantalla de semaforo
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.add_chart, color: Theme.of(context).colorScheme.primary),
                    title: Text(
                      'Vortal',
                      style: TextStyle(
                        color: currentRoute == '/vortal'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: currentRoute == '/vortal' ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: currentRoute == '/vortal',
                    onTap: () {
                      if (currentRoute != '/vortal') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const WebViewPage()),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.add_chart, color: Theme.of(context).colorScheme.primary),
                    title: Text(
                      'Aulaweb',
                      style: TextStyle(
                        color: currentRoute == '/aulaweb'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: currentRoute == '/aulaweb' ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: currentRoute == '/aulaweb',
                    onTap: () {
                      if (currentRoute != '/aulaweb') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AulaWebViewPage()),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.checklist, color: Theme.of(context).colorScheme.primary),
                    title: Text(
                      'Plan de estudio',
                      style: TextStyle(
                        color: currentRoute == '/configuracion'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: currentRoute == '/configuracion'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    selected: currentRoute == '/configuracion',
                    onTap: () {
                      if (currentRoute != '/configuracion') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const SettingsScreen()),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(EvaIcons.settings2Outline, color: Theme.of(context).colorScheme.primary),
                    title: Text(
                      'Ajustes',
                      style: TextStyle(
                        color: currentRoute == '/configuracion'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: currentRoute == '/configuracion'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    selected: currentRoute == '/configuracion',
                    onTap: () {
                      if (currentRoute != '/configuracion') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const SettingsScreen()),
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
            /*Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 12,
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.amber,
                        width: 1.5,
                      ),
                      color: const Color(0xFF1C1C2E),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                colors: <Color>[
                                  Colors.cyan,
                                  Colors.blue,
                                  Colors.purple,
                                  Colors.pink,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds);
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.circleArrowUp),
                                SizedBox(width: 12),
                                Text(
                                  'Nexo Premium',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
