import 'package:flutter/material.dart';

class TerritoriCommerciali extends StatefulWidget {
  const TerritoriCommerciali({super.key});

  @override
  State<TerritoriCommerciali> createState() => _TerritoriCommercialiState();
}

class _TerritoriCommercialiState extends State<TerritoriCommerciali> {
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
        child: Text('Territori commerciali'),
      ),
    );
  }
}
