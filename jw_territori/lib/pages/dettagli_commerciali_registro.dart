// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jw_territori/models/territorio_commerciale_model.dart';
import '../services/firestore_helper.dart';
import '../widgets/elenco_registro_commerciale_card.dart';

class DettagliCommercialiRegistro extends StatefulWidget {
  DettagliCommercialiRegistro(
      {super.key, required this.index, required this.territorioCommerciale});

  TerritorioCommercialeModel territorioCommerciale;
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
        title:
            Text('Registro territorio ${widget.territorioCommerciale.lettera}'),
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
              stream: FirestoreHelper.readElencoRegistroCommerciali(
                  widget.territorioCommerciale.lettera),
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
                      return ElencoRegistroCommercialeCard(
                        cardRegistroCommerciale: singleCardElenco,
                        lettera: widget.territorioCommerciale.lettera!,
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
