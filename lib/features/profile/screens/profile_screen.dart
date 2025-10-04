import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:hugeicons/styles/stroke_rounded.dart';
import 'package:nexo/features/profile/screens/edit_profile_screen.dart';
import 'package:nexo/features/profile/widgets/more_actions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final docRef =
    FirebaseFirestore.instance.collection('users').doc(user.uid);

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: docRef.snapshots(),
      builder: (context, snap) {
        // Loading
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // No data
        if (!snap.hasData || !snap.data!.exists) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon:
                const HugeIcon(icon: HugeIconsStrokeRounded.arrowLeft01, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: const Center(child: Text('Sin datos del usuario')),
          );
        }

        // Casts SEGUROS
        final raw = snap.data!.data();
        final data = raw == null
            ? <String, dynamic>{}
            : Map<String, dynamic>.from(raw);

        final name = (data['name'] ?? '').toString();
        final program = (data['program'] ?? 'Sin programa').toString();
        final username = (data['username'] ?? '@usuario').toString();
        final phoneLabel = (data['phoneLabel'] ?? 'Móvil').toString();

        final nextTask =
        Map<String, dynamic>.from(data['nextTask'] ?? <String, dynamic>{});

        final taskTitle = (nextTask['title'] ?? '—').toString();
        final taskBy = (nextTask['scheduledBy'] ?? '—').toString();
        final taskRoom = (nextTask['room'] ?? '—').toString();

        final dueAtRaw = nextTask['dueAt'];
        String dueText = '—';
        if (dueAtRaw is Timestamp) {
          dueText = _fmtDateHour(dueAtRaw.toDate());
        } else if (dueAtRaw is String && dueAtRaw.isNotEmpty) {
          final dt = DateTime.tryParse(dueAtRaw);
          if (dt != null) dueText = _fmtDateHour(dt.toLocal());
        }

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: const HugeIcon(icon: HugeIconsStrokeRounded.arrowLeft01, size: 32, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: HugeIcon(icon: HugeIcons.strokeRoundedPencilEdit01, color: Colors.white),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                  );
                },
              ),

              ProfileMoreMenuButton(
                username: username,
                userId: user.uid,
                onEditInfo: () {},
                onSetPhoto: () async {},
                onChangeColor: () async {},
                onChangeUsername: () async {},
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      _initialsSafe(name: name, email: user.email),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    name.isNotEmpty ? name : 'Sin nombre',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "en línea",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ---------- Tarjeta: Información ----------
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF232336),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Información",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7C83FF),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          user.email ?? "Sin correo registrado",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          phoneLabel,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          program,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "Programa",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          username,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "Nombre de usuario",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ---------- Tarjeta: Próxima tarea ----------
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF232336),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Próxima tarea",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          taskTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          taskBy,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          dueText,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "Fecha",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          taskRoom,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "Salón",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Iniciales seguras para el avatar.
/// Si `name` está vacío, usa el correo como respaldo.
String _initialsSafe({String? name, String? email}) {
  final n = (name ?? '').trim();
  if (n.isNotEmpty) {
    final parts =
    n.split(RegExp(r'\s+')).where((s) => s.isNotEmpty).toList();
    final first = parts.first.substring(0, 1);
    final second = parts.length > 1 ? parts.last.substring(0, 1) : '';
    return (first + second).toUpperCase();
  }

  // fallback: email
  final e = (email ?? '').trim();
  if (e.isNotEmpty) {
    final handle = e.contains('@') ? e.split('@').first : e;
    if (handle.isNotEmpty) return handle.substring(0, 1).toUpperCase();
  }

  return '?';
}

/// Formato simple dd/MM/yyyy h:mmAM/PM
String _fmtDateHour(DateTime dt) {
  String two(int n) => n.toString().padLeft(2, '0');
  final h12 = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
  final ampm = dt.hour >= 12 ? 'PM' : 'AM';
  return "${two(dt.day)}/${two(dt.month)}/${dt.year} $h12:${two(dt.minute)}$ampm";
}
