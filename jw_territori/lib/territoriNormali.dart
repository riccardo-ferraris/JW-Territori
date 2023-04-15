import 'package:flutter/material.dart';

class TerritoriNormali extends StatefulWidget {
  const TerritoriNormali({super.key});

  @override
  State<TerritoriNormali> createState() => _TerritoriNormaliState();
}

class _TerritoriNormaliState extends State<TerritoriNormali> {
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
      body: Center(
        child: Text('Territori normali'),
      ),
    );
  }
}
