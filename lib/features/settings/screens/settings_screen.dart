import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nexo/features/settings/widgets/custom_list_tile.dart';
import 'package:nexo/routes.dart';
import '../../../share/widgets/drawer_scaffold.dart';
import '../../auth/services/auth_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = FirebaseAuth.instance.currentUser;

    return DrawerScaffold(
      title: 'Configuración',
      currentRoute: '/settings',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  'AG',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Andres Grijalba",
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                "✈️",
                style: textTheme.bodySmall?.copyWith(color: Colors.grey[400]),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  size: 18,
                  color: Colors.white,
                ),
                label: const Text(
                  "Editar foto de perfil",
                  style: TextStyle(color: Colors.grey),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white10,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              "Cuenta",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const CustomListTile(
            leading: Icon(Icons.edit_outlined),
            title: "Andres Grijalba",
            subtitle: "Toca para cambiar tu nombre",
          ),
          CustomListTile(
            leading: Icon(Icons.alternate_email_outlined),
            title: user?.email ?? "Sin correo registrado",
            subtitle: "Correo",
          ),
          const CustomListTile(
            leading: Icon(EvaIcons.infoOutline),
            title: "✈️",
            subtitle: "Info",
          ),
          const SizedBox(height: 38),

          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              "Ajustes",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CustomListTile(
            leading: Icon(EvaIcons.colorPaletteOutline),
            title: "Personalización",
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.theme);
            },
          ),
          CustomListTile(
            leading: Icon(EvaIcons.lockOutline),
            title: "Privacidad y seguridad",
            onTap: () {},
          ),
          CustomListTile(
            leading: Icon(Icons.notifications_outlined),
            title: "Notificaciones y sonidos",
            onTap: () {},
          ),
          
          const SizedBox(height: 20),

          CustomListTile(
            leading: SvgPicture.asset("assets/images/svg/nexologopremium24.svg"),
            title: "Nexo Premium",
            onTap: () {},
          ),

          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () async {
                await AuthService().signOut();
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                "Cerrar sesión",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
