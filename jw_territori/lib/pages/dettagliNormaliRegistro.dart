import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DettagliNormaliRegistro extends StatefulWidget {
  DettagliNormaliRegistro({super.key, required this.index});

  int index;

  @override
  State<DettagliNormaliRegistro> createState() =>
      _DettagliNormaliRegistroState();
}

class _DettagliNormaliRegistroState extends State<DettagliNormaliRegistro> {
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
              return Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1)),
                    child: const Text('Assegnato a:'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: const Text('Data Uscita:'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: const Text('Data Rientro:'),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ),
    );
  }
}
