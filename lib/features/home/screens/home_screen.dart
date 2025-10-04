import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexo/features/profile/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 60,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              child: Center(
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Text(
                      'AG',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              width:double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withAlpha(40),
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
                    user?.email ?? "Sin correo registrado",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "Correo electronico",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "✈️",
                    style: TextStyle(fontSize: 18),
                  ),
                  const Text(
                    "Biografía",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "@andrewgroa",
                    style: TextStyle(
                      fontSize: 16,
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

            const SizedBox(height: 20,),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withAlpha(40),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Próxima tarea",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Entregar primera entrega de P. Movil",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Programada por estudiante",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Mañana 2:00PM",
                    style: TextStyle(
                        fontSize: 18,
                    ),
                  ),
                  Text(
                    "Fecha",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "302I",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Salon",
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
    );
  }
}