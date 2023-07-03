import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CalculateAverage extends StatelessWidget {
  const CalculateAverage({super.key});

  Future<double> calculateAverage() async {
    DateTime now = DateTime.now();
    DateTime sixMonthsAgo;
    if (now.month >= 6) {
      sixMonthsAgo = DateTime(now.year, now.month - 6, now.day);
    } else {
      int previousYear = now.year - 1;
      int previousMonth = 12 - (6 - now.month);
      sixMonthsAgo = DateTime(previousYear, previousMonth, now.day);
    }

    int documentCount = 0;

    // for (int i = 0; i < 72; i++) {
    //   QuerySnapshot snapshot = await FirebaseFirestore.instance
    //       .collection('Registro')
    //       .doc(i.toString())
    //       .collection('Elenco')
    //       .where('timestamp', isGreaterThanOrEqualTo: sixMonthsAgo)
    //       .where('dataRientro', isNotEqualTo: '')
    //       .get();
    //   documentCount = documentCount + snapshot.docs.length;
    // }

    for (int i = 1; i <= 72; i++) {
      final snapshot1 = await FirebaseFirestore.instance
          .collection('Registro')
          .doc(i.toString())
          .collection('Elenco')
          .where('timestamp', isGreaterThanOrEqualTo: sixMonthsAgo)
          .get();

      final snapshot2 = await FirebaseFirestore.instance
          .collection('Registro')
          .doc(i.toString())
          .collection('Elenco')
          .where('dataRientro', isNotEqualTo: '')
          .get();

      final documentiQuery1 = snapshot1.docs.map((doc) => doc.id).toSet();
      final documentiQuery2 = snapshot2.docs.map((doc) => doc.id).toSet();
      final documentiComuni = documentiQuery1.intersection(documentiQuery2);

      documentCount = documentCount + documentiComuni.length;
    }

    if (documentCount != 0) {
      double result = (72 * 6) / documentCount;
      return double.parse(result.toStringAsFixed(2));
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcolo Media'),
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
      body: FutureBuilder<double>(
        future: calculateAverage(),
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text(
              'Errore nella lettura del valore',
              style: TextStyle(fontSize: 40),
            ));
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Formula utilizzata:',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Numero Territori x Numero mesi',
                  style: TextStyle(fontSize: 20),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Numero rientri',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Media: ${snapshot.data}',
                  style: const TextStyle(fontSize: 40),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
