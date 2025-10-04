import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers Información
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();     // readOnly
  final _usernameCtrl = TextEditingController();  // readOnly derivado
  String? _program;                               // dropdown

  bool _loading = true;

  // Opciones del programa
  static const _programOptions = <String>[
    'Ingeniería de Sistemas',
    'Ingeniería Electrónica',
    'Ingeniería Industrial',
    'Administración',
    'Contaduría',
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      _emailCtrl.text = user.email ?? '';

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final data = doc.data() == null
          ? <String, dynamic>{}
          : Map<String, dynamic>.from(doc.data()!);

      // Información
      _nameCtrl.text = (data['name'] ?? '').toString();
      final programRaw = (data['program'] ?? '').toString();
      _program = programRaw.isNotEmpty ? programRaw : null;

      // username derivado del email (solo lectura)
      _usernameCtrl.text = _deriveUsernameFromEmail(_emailCtrl.text);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo cargar: $e')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final user = FirebaseAuth.instance.currentUser!;
      final username = _deriveUsernameFromEmail(_emailCtrl.text);

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': _nameCtrl.text.trim(),
        'program': _program ?? '',
        'username': username, // derivado del correo
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (!mounted) return;
      Navigator.pop(context); // volver al perfil
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo guardar: $e')),
      );
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _usernameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar información'),
      ),
      body: _loading
          ? const _EditInfoSkeleton() // 👈 esqueleto mientras carga
          : Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // -------- Tarjeta: Información --------
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

                    // Nombre
                    _LabeledField(
                      label: 'Nombres y apellidos',
                      child: TextFormField(
                        controller: _nameCtrl,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Requerido';
                          }
                          if (v.trim().length < 3) {
                            return 'Mínimo 3 caracteres';
                          }
                          return null;
                        },
                        decoration:
                        _decor(Icons.person, 'Ej: Andres Grijalba'),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Programa (Dropdown)
                    _LabeledField(
                      label: 'Programa',
                      child: DropdownButtonFormField<String>(
                        value: _program,
                        isExpanded: true,
                        items: _programOptions
                            .map((p) => DropdownMenuItem<String>(
                          value: p,
                          child: Text(p),
                        ))
                            .toList(),
                        onChanged: (v) => setState(() => _program = v),
                        validator: (v) => (v == null || v.isEmpty)
                            ? 'Selecciona un programa'
                            : null,
                        decoration: _decor(
                            Icons.school, 'Selecciona tu programa'),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Email (solo lectura)
                    _LabeledField(
                      label: 'Correo electrónico',
                      child: TextFormField(
                        controller: _emailCtrl,
                        readOnly: true,
                        decoration: _decor(Icons.email, '')
                            .copyWith(hintText: null),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Username (solo lectura)
                    _LabeledField(
                      label: 'Nombre de usuario',
                      child: TextFormField(
                        controller: _usernameCtrl,
                        readOnly: true,
                        decoration: _decor(Icons.alternate_email, '')
                            .copyWith(hintText: null),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // -------- Botón Guardar --------
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// -------------------- Helpers de UI --------------------
//

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textStyle.bodySmall?.copyWith(color: Colors.grey[500])),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

InputDecoration _decor(IconData icon, String hint) {
  return InputDecoration(
    hintText: hint.isEmpty ? null : hint,
    prefixIcon: Icon(icon, size: 18, color: Colors.grey[600]),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: const Color(0xFF3A3A4A)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: const Color(0xFF3A3A4A)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Color(0xFF1dd4d2)),
    ),
    filled: true,
    fillColor: const Color(0xFF2C2C3A),
  );
}

//
// -------------------- Esqueleto (Skeleton) --------------------
//

/// Esqueleto para la pantalla "Editar información"
class _EditInfoSkeleton extends StatelessWidget {
  const _EditInfoSkeleton();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          _SkeletonCard(),
          SizedBox(height: 24),
          _SkelButton(width: double.infinity, height: 48),
        ],
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF232336),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _SkelLine(width: 110, height: 16, color: Color(0xFF39405F)),
          SizedBox(height: 12),

          _SkelLine(width: 140, height: 12),
          SizedBox(height: 6),
          _SkelInputWithIcon(),

          SizedBox(height: 12),

          _SkelLine(width: 80, height: 12),
          SizedBox(height: 6),
          _SkelInputWithIcon(),

          SizedBox(height: 12),

          _SkelLine(width: 130, height: 12),
          SizedBox(height: 6),
          _SkelInputWithIcon(),

          SizedBox(height: 12),

          _SkelLine(width: 150, height: 12),
          SizedBox(height: 6),
          _SkelInputWithIcon(),
        ],
      ),
    );
  }
}

/// Línea rectangular redondeada (placeholder con leve “latido”)
class _SkelLine extends StatefulWidget {
  const _SkelLine({
    this.width = double.infinity,
    this.height = 12,
    this.color,
    Key? key,
  }) : super(key: key);

  final double width;
  final double height;
  final Color? color;

  @override
  State<_SkelLine> createState() => _SkelLineState();
}

class _SkelLineState extends State<_SkelLine> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _a;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _a = Tween(begin: 0.55, end: 0.9)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = widget.color ?? const Color(0xFF3A3A4A);
    return FadeTransition(
      opacity: _a,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: base,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

/// Placeholder con aspecto de TextField (borde redondeado + icono fantasma)
class _SkelInputWithIcon extends StatelessWidget {
  const _SkelInputWithIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48, // coincide con tus TextFormField
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C3A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF3A3A4A)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: const [
          _SkelCircle(size: 18),
          SizedBox(width: 10),
          Expanded(child: _SkelLine(height: 14)),
        ],
      ),
    );
  }
}

class _SkelButton extends StatelessWidget {
  const _SkelButton({required this.width, required this.height, Key? key}) : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C3A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF3A3A4A)),
      ),
      alignment: Alignment.center,
      child: const _SkelLine(width: 80, height: 14),
    );
  }
}

class _SkelCircle extends StatelessWidget {
  const _SkelCircle({required this.size, Key? key}) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: const BoxDecoration(
        color: Color(0xFF3A3A4A),
        shape: BoxShape.circle,
      ),
    );
  }
}

String _deriveUsernameFromEmail(String email) {
  final local = (email.split('@').first).trim();
  var cleaned = local.replaceAll(RegExp(r'\d'), '');
  cleaned = cleaned.toLowerCase();
  cleaned = cleaned.replaceAll(RegExp(r'[^a-z._-]'), '');
  cleaned = cleaned.replaceAll(RegExp(r'[._-]{2,}'), '_');
  cleaned = cleaned.replaceAll(RegExp(r'^[._-]+|[._-]+$'), '');
  if (cleaned.isEmpty) {
    cleaned = local.toLowerCase().replaceAll(RegExp(r'\s+'), '');
  }
  return cleaned;
}
