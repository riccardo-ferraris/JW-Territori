import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: const Color(0xFF5A2D81),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Registro'),
      ),
    );
  }
}
