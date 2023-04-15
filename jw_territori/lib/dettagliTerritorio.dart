// ignore: file_names
import 'package:flutter/material.dart';

class DettagliTerritorio extends StatefulWidget {
  const DettagliTerritorio({super.key});

  @override
  State<DettagliTerritorio> createState() => _DettagliTerritorioState();
}

class _DettagliTerritorioState extends State<DettagliTerritorio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A2D81),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // !TODO: Creare l'interruzione di sessione
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Dettagli territorio'),
      ),
    );
  }
}
