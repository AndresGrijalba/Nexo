import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:nexo/features/settings/widgets/custom_list_tile.dart';
import 'package:nexo/routes.dart';
import '../../auth/services/auth_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración"),
        centerTitle: true,
      ),
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
                icon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedImageUpload,
                  size: 20,
                ),
                label: const Text(
                  "Editar foto de perfil",
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(200),
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
            leading: HugeIcon(icon: HugeIcons.strokeRoundedPencilEdit01),
            title: "Andres Grijalba",
            subtitle: "Toca para cambiar tu nombre",
          ),
          CustomListTile(
            leading: HugeIcon(icon: HugeIcons.strokeRoundedMailAtSign02),
            title: user?.email ?? "Sin correo registrado",
            subtitle: "Correo",
          ),
          const CustomListTile(
            leading: HugeIcon(icon: HugeIcons.strokeRoundedInformationCircle),
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
            leading: HugeIcon(icon: HugeIcons.strokeRoundedPaintBoard),
            title: "Personalización",
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.theme);
            },
          ),
          CustomListTile(
            leading: HugeIcon(icon: HugeIcons.strokeRoundedLockPassword),
            title: "Privacidad y seguridad",
            onTap: () {},
          ),
          CustomListTile(
            leading: HugeIcon(icon: HugeIcons.strokeRoundedNotification01),
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
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (Route<dynamic> route) => false,);
              },
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedLogoutSquare01, color: Colors.white),
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
          const SizedBox(height: 80)
        ],
      ),
    );
  }
}
