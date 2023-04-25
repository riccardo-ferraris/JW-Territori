import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jw_territori/pages/elencoNormaliRegistro.dart';

import 'elencoCommercialiRegistro.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registro'),
          backgroundColor: const Color(0xFF5A2D81),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            indicatorWeight: 3,
            tabs: [
              Tab(
                text: 'Residenziali',
              ),
              Tab(
                text: 'Commerciali',
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              itemCount: 72,
              itemBuilder: (BuildContext context, int index) {
                return ElencoNormaliRegistro(index: ++index);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
            ),
            GridView.builder(
              itemCount: 11,
              itemBuilder: (BuildContext context, int index) {
                return ElencoCommercialiRegistro(index: ++index);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
