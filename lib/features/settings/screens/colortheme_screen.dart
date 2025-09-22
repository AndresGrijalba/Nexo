import 'package:flutter/material.dart';
import 'package:nexo/features/settings/widgets/color_circle.dart';
import '../../../core/theme/theme_controller.dart';

class ColorThemeScreen extends StatelessWidget {
  const ColorThemeScreen({super.key});
  static const Color defaultColor = Color(0xFF19D9D7);

  Widget _buildColorCircle(BuildContext context, Color color, {bool isDefault = false}) {
    return ValueListenableBuilder<Color>(
      valueListenable: ThemeController.colorNotifier,
      builder: (_, selectedColor, __) {
        final theme = Theme.of(context).colorScheme;
        final circleBackgroundColor = Theme.of(context).brightness == Brightness.dark
            ? theme.surface
            : Colors.grey.shade300;

        return GestureDetector(
          onTap: () {
            ThemeController.colorNotifier.value = color;
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              DiagonalColorCircle(
                mainColor: color,
                backgroundColor: isDefault ? theme.surface : circleBackgroundColor,
                size: 40,
              ),
              if (selectedColor == color)
                const Icon(Icons.check, color: Colors.white),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Personalización",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tema',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<ThemeMode>(
              valueListenable: ThemeController.themeNotifier,
              builder: (context, mode, _) {
                return Column(
                  children: [
                    RadioListTile<ThemeMode>(
                      title: const Text('🌞  Claro'),
                      value: ThemeMode.light,
                      groupValue: mode,
                      onChanged: (value) {
                        if (value != null) {
                          ThemeController.themeNotifier.value = value;
                        }
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: const Text('🌙  Oscuro'),
                      value: ThemeMode.dark,
                      groupValue: mode,
                      onChanged: (value) {
                        if (value != null) {
                          ThemeController.themeNotifier.value = value;
                        }
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: const Text('⚙️  Predeterminado del sistema'),
                      value: ThemeMode.system,
                      groupValue: mode,
                      onChanged: (value) {
                        if (value != null) {
                          ThemeController.themeNotifier.value = value;
                        }
                      },
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Color de la interfaz',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                _buildColorCircle(context, defaultColor),
                _buildColorCircle(context, Colors.teal),
                _buildColorCircle(context, Colors.blue),
                _buildColorCircle(context, const Color(0xFFB330AD)),
                _buildColorCircle(context, Colors.red),
                _buildColorCircle(context, Colors.yellow),
                _buildColorCircle(context, Colors.green),
              ],
            )
          ],
        ),
      ),
    );
  }
}
