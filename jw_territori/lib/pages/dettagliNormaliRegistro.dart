import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jw_territori/services/firestoreHelper.dart';
import 'package:jw_territori/widgets/elencoRegistroCard.dart';

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
    final elencoAssegnazioneCollection = FirebaseFirestore.instance
        .collection('Registro')
        .doc(widget.index.toString())
        .collection('Elenco')
        .snapshots();

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
              stream: elencoAssegnazioneCollection,
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
                  var registroCard = snapshot.data!.docs;

                  return ListView.separated(
                    itemCount: registroCard.length,
                    itemBuilder: (context, index) {
                      return ElencoRegistroCard();
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
