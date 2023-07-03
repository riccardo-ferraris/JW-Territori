// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jw_territori/services/firestore_helper.dart';

import '../widgets/elenco_registro_normale_card.dart';

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
          child: StreamBuilder(
              stream: FirestoreHelper.readElencoRegistroNormali(widget.index),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Some error occurred!'),
                  );
                }
                if (snapshot.hasData) {
                  var registroCard = snapshot.data!;

                  return ListView.separated(
                    itemCount: registroCard.length,
                    itemBuilder: (context, index) {
                      final singleCardElenco = registroCard[index];
                      return ElencoRegistroNormaleCard(
                        cardRegistroNormale: singleCardElenco,
                        index: widget.index,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}
