import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jw_territori/widgets/elencoRegistroCard.dart';

class DettagliCommercialiRegistro extends StatefulWidget {
  DettagliCommercialiRegistro({super.key, required this.index});

  int index;

  @override
  State<DettagliCommercialiRegistro> createState() =>
      _DettagliCommercialiRegistroState();
}

class _DettagliCommercialiRegistroState
    extends State<DettagliCommercialiRegistro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro territorio ${widget.index}'),
        backgroundColor: const Color(0xFF5A2D81),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView.separated(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ElencoRegistroCard();
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ),
    );
  }
}
