// lib/widgets/profile_more_menu.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileMoreMenuButton extends StatelessWidget {
  const ProfileMoreMenuButton({
    super.key,
    required this.username,
    required this.userId,
    this.onEditInfo,
    this.onSetPhoto,
    this.onChangeColor,
    this.onChangeUsername,
    this.profileUrlBuilder,
    this.menuColor = const Color(0xFF2B2B36),
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 16),
    this.iconColor = Colors.white70,
  });

  final String username;
  final String userId;

  final VoidCallback? onEditInfo;
  final VoidCallback? onSetPhoto;
  final VoidCallback? onChangeColor;
  final VoidCallback? onChangeUsername;

  final String Function(String username, String userId)? profileUrlBuilder;
  final Color menuColor;
  final TextStyle textStyle;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final popupTheme = PopupMenuTheme.of(context);

    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: popupTheme.copyWith(
          color: menuColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: textStyle,
        ),
      ),
      child: PopupMenuButton<_MoreAction>(
        icon: Icon(Icons.more_vert, color: Colors.white),
        elevation: 6,
        position: PopupMenuPosition.under,
        onSelected: (value) async {
          switch (value) {
            case _MoreAction.editInfo:
              onEditInfo?.call();
              break;
            case _MoreAction.setPhoto:
              onSetPhoto?.call();
              break;
            case _MoreAction.changeColor:
              onChangeColor?.call();
              break;
            case _MoreAction.changeUsername:
              onChangeUsername?.call();
              break;
            case _MoreAction.copyLink:
              final url = (profileUrlBuilder ?? _defaultProfileUrl)(username, userId);
              await Clipboard.setData(ClipboardData(text: url));
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enlace copiado')),
                );
              }
              break;
          }
        },
        itemBuilder: (context) => [
          _tile(_MoreAction.editInfo,        Icons.edit,              'Editar información', iconColor),
          _tile(_MoreAction.setPhoto,        Icons.photo_camera,      'Establecer foto de perfil', iconColor),
          _tile(_MoreAction.changeColor,     Icons.color_lens,        'Cambiar color del perfil', iconColor),
          _tile(_MoreAction.changeUsername,  Icons.alternate_email,   'Cambiar nombre de usuario', iconColor),
          const PopupMenuDivider(height: 8),
          _tile(_MoreAction.copyLink,        Icons.link,              'Copiar enlace al perfil', iconColor),
        ],
      ),
    );
  }

  static PopupMenuItem<_MoreAction> _tile(
      _MoreAction value,
      IconData icon,
      String label,
      Color iconColor,
      ) {
    return PopupMenuItem<_MoreAction>(
      value: value,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 12),
          Text(label),
        ],
      ),
    );
  }

  static String _defaultProfileUrl(String username, String userId) {
    // Ajusta a tu esquema real de deep-link o web:
    // return 'https://nexo.app/u/$username';
    return 'nexo://profile/$userId';
  }
}

enum _MoreAction { editInfo, setPhoto, changeColor, changeUsername, copyLink }
