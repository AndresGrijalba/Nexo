import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget leading; // 👈 ahora acepta cualquier widget (icono o imagen)
  final VoidCallback? onTap;

  const CustomListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.leading, // 👈 cambiado
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(left: 5, right: 0),
          leading: leading, // 👈 se usa directamente
          title: Text(title),
          subtitle: subtitle != null
              ? Text(
            subtitle!,
            style: const TextStyle(color: Colors.grey),
          )
              : null,
          onTap: onTap,
        ),
        Container(
          height: 1,
          margin: const EdgeInsets.only(left: 45, right: 24),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }
}
