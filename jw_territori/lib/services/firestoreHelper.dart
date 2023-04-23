import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_territori/models/territorioNormaleModel.dart';

import '../models/territorioCommercialeModel.dart';

final territoriCollection =
    FirebaseFirestore.instance.collection('"Territori"');

class FirestoreHelper {
// ! READ DI TUTTI
  static Stream<List<TerritorioNormaleModel>> readAllNormali() {
    final queryTuttiNormali = territoriCollection
        .where('isNormale', isEqualTo: true)
        .orderBy('numero');
    return queryTuttiNormali.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((e) => TerritorioNormaleModel.fromSnapshot(e))
        .toList());
  }

  static Stream<List<TerritorioCommercialeModel>> readAllCommerciali() {
    final queryTuttiCommerciali = territoriCollection
        .where('isNormale', isEqualTo: false)
        .orderBy('lettera');
    return queryTuttiCommerciali.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((e) => TerritorioCommercialeModel.fromSnapshot(e))
            .toList());
  }

  // ! DISPONIBILI
  // ! ORDINARE PER DATA RIENTRO
  static Stream<List<TerritorioNormaleModel>> readNormaliDisponibili() {
    final queryDisponibili = territoriCollection
        .where('isDisponibile', isEqualTo: true)
        .where('isNormale', isEqualTo: true)
        .orderBy('numero');

    return queryDisponibili.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((e) => TerritorioNormaleModel.fromSnapshot(e))
        .toList());
  }

  // ! ORDINARE PER DATA RIENTRO
  static Stream<List<TerritorioCommercialeModel>> readCommercialiDisponibili() {
    final queryDisponibili = territoriCollection
        .where('isDisponibile', isEqualTo: true)
        .where('isNormale', isEqualTo: false)
        .orderBy('lettera');

    return queryDisponibili.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((e) => TerritorioCommercialeModel.fromSnapshot(e))
        .toList());
  }

  // ! NON DISPONIBILI
  // ! ORDINARE PER DATA RIENTRO
  static Stream<List<TerritorioNormaleModel>> readNormaliNonDisponibili() {
    final queryDisponibili = territoriCollection
        .where('isDisponibile', isEqualTo: false)
        .where('isNormale', isEqualTo: true)
        .orderBy('numero');

    return queryDisponibili.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((e) => TerritorioNormaleModel.fromSnapshot(e))
        .toList());
  }

  // ! ORDINARE PER DATA RIENTRO
  static Stream<List<TerritorioCommercialeModel>>
      readCommercialiNonDisponibili() {
    final queryDisponibili = territoriCollection
        .where('isDisponibile', isEqualTo: false)
        .where('isNormale', isEqualTo: false)
        .orderBy('lettera');

    return queryDisponibili.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((e) => TerritorioCommercialeModel.fromSnapshot(e))
        .toList());
  }

  static Future updateRiconsegnaNormali(String dataAttuale, int? numero) async {
    final docRef = territoriCollection.doc(numero.toString());
    final newTerritorioNormale = TerritorioNormaleModel(
            fratelloInPossesso: 'Fratello in possesso',
            dataLimite: 'Data Limite',
            dataUscita: 'Data Uscita',
            isDisponibile: true,
            dataRientro: dataAttuale,
            isNormale: true,
            numero: numero)
        .toJson();

    try {
      await docRef.set(newTerritorioNormale);
    } catch (e) {
      print('Some error occurred $e');
    }
  }

  static Future updateAffidaNormali(
      String dataAttuale, int? numero, String fratello) async {
    final String dataRientroFormat;
    DateTime now = DateTime.now();
    if (now.month + 4 > 12) {
      dataRientroFormat = '${now.day}/${now.month - 8}/${now.year + 1}';
    } else {
      dataRientroFormat = '${now.day}/${now.month + 4}/${now.year}';
    }
    ;
    final docRef = territoriCollection.doc(numero.toString());
    final newTerritorioNormale = TerritorioNormaleModel(
            fratelloInPossesso: fratello,
            dataLimite: dataRientroFormat,
            dataUscita: dataAttuale,
            isDisponibile: false,
            dataRientro: 'Data Rientro',
            isNormale: true,
            numero: numero)
        .toJson();

    try {
      await docRef.set(newTerritorioNormale);
    } catch (e) {
      print('Some error occurred $e');
    }
  }
}
