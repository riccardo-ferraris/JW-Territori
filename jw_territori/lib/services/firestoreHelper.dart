import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jw_territori/models/cardRegistroNormaleModel.dart';
import 'package:jw_territori/models/territorioNormaleModel.dart';

import '../models/cardRegistroCommercialeModel.dart';
import '../models/territorioCommercialeModel.dart';

final territoriCollection =
    FirebaseFirestore.instance.collection('"Territori"');

final elencoAssegnazione = FirebaseFirestore.instance.collection('Registro');

class FirestoreHelper {
  //! CREATE TOAST
  static createToast(String textMessage) {
    Fluttertoast.showToast(
        msg: textMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  //! SET NAME
  static setName(FirebaseAuth currentUser) {
    if (FirebaseAuth.instance.currentUser!.email!.contains('scotti')) {
      return 'Vincenzo Scotti';
    } else if (FirebaseAuth.instance.currentUser!.email!.contains('ferraris')) {
      return 'Riccardo Kevin Ferraris';
    } else if (FirebaseAuth.instance.currentUser!.email!
        .contains('delgiudice')) {
      return 'Francesco Del Giudice';
    } else if (FirebaseAuth.instance.currentUser!.email!.contains('matino')) {
      return 'Antonio Matino';
    } else if (FirebaseAuth.instance.currentUser!.email!.contains('kekko')) {
      return 'Francesco Caracciolo';
    } else if (FirebaseAuth.instance.currentUser!.email!.contains('ammaturo')) {
      return 'Pietro Ammaturo';
    } else {
      return FirebaseAuth.instance.currentUser!.email;
    }
  }

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

  // ! READ DI TUTTI SORTED
  static Stream<List<TerritorioNormaleModel>> readAllNormaliSorted() {
    final queryTuttiNormali = territoriCollection
        .where('isNormale', isEqualTo: true)
        .orderBy('timestamp');
    return queryTuttiNormali.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((e) => TerritorioNormaleModel.fromSnapshot(e))
        .toList());
  }

  static Stream<List<TerritorioCommercialeModel>> readAllCommercialiSorted() {
    final queryTuttiCommerciali = territoriCollection
        .where('isNormale', isEqualTo: false)
        .orderBy('timestamp');
    return queryTuttiCommerciali.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((e) => TerritorioCommercialeModel.fromSnapshot(e))
            .toList());
  }

  // ! DISPONIBILI
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

  // ! DISPONIBILI SORTED
  static Stream<List<TerritorioNormaleModel>> readNormaliDisponibiliSorted() {
    final queryDisponibili = territoriCollection
        .where('isDisponibile', isEqualTo: true)
        .where('isNormale', isEqualTo: true)
        .orderBy('timestamp');

    return queryDisponibili.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((e) => TerritorioNormaleModel.fromSnapshot(e))
        .toList());
  }

  static Stream<List<TerritorioCommercialeModel>>
      readCommercialiDisponibiliSorted() {
    final queryDisponibili = territoriCollection
        .where('isDisponibile', isEqualTo: true)
        .where('isNormale', isEqualTo: false)
        .orderBy('timestamp');

    return queryDisponibili.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((e) => TerritorioCommercialeModel.fromSnapshot(e))
        .toList());
  }

  // ! NON DISPONIBILI
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

  // ! NON DISPONIBILI SORTED
  static Stream<List<TerritorioNormaleModel>>
      readNormaliNonDisponibiliSorted() {
    final queryDisponibili = territoriCollection
        .where('isDisponibile', isEqualTo: false)
        .where('isNormale', isEqualTo: true)
        .orderBy('timestamp');

    return queryDisponibili.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((e) => TerritorioNormaleModel.fromSnapshot(e))
        .toList());
  }

  static Stream<List<TerritorioCommercialeModel>>
      readCommercialiNonDisponibiliSorted() {
    final queryDisponibili = territoriCollection
        .where('isDisponibile', isEqualTo: false)
        .where('isNormale', isEqualTo: false)
        .orderBy('timestamp');

    return queryDisponibili.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((e) => TerritorioCommercialeModel.fromSnapshot(e))
        .toList());
  }

//! UPDATE TERRITORI NORMALI
  static Future updateRiconsegnaNormali(String dataAttuale, int? numero,
      String? fratello, String? dataUscita, String? id) async {
    final elencoAssegnazioneCollection =
        elencoAssegnazione.doc(numero.toString()).collection('Elenco');

    final docRef = territoriCollection.doc(numero.toString());

    final newTerritorioNormale = TerritorioNormaleModel(
      fratelloInPossesso: 'Proclamatore in possesso',
      dataLimite: 'Data Limite',
      dataUscita: 'Data Uscita',
      isDisponibile: true,
      dataRientro: dataAttuale,
      isNormale: true,
      numero: numero,
      id: id,
      timestamp: FieldValue.serverTimestamp(),
    ).toJson();
    final docRef2 = elencoAssegnazioneCollection.doc(id);
    try {
      await docRef.update(newTerritorioNormale);
      await docRef2.update({
        'id': id,
        'fratelloInPossesso': fratello,
        'dataRientro': dataAttuale,
        'dataUscita': dataUscita,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Some error occurred $e');
    }
  }

  static Future updateAffidaNormali(
      String dataAttuale, int? numero, String fratello) async {
    final String dataRientroFormat;
    DateTime now = DateTime.now();

    DateTime dataRientro;
    dataRientro = now.add(const Duration(days: 120));
    dataRientroFormat =
        '${dataRientro.day}/${dataRientro.month}/${dataRientro.year}';

    final docRef = territoriCollection.doc(numero.toString());
    final elencoAssegnazioneCollection =
        elencoAssegnazione.doc(numero.toString()).collection('Elenco');

    final docRef2 = elencoAssegnazioneCollection.doc();
    final newTerritorioNormale = TerritorioNormaleModel(
      fratelloInPossesso: fratello,
      dataLimite: dataRientroFormat,
      dataUscita: dataAttuale,
      isDisponibile: false,
      dataRientro: 'Data Rientro',
      isNormale: true,
      numero: numero,
      id: docRef2.id,
      timestamp: FieldValue.serverTimestamp(),
    ).toJson();

    try {
      await docRef.update(newTerritorioNormale);
      await docRef2.set({
        'id': docRef2.id,
        'fratelloInPossesso': fratello,
        'dataUscita': dataAttuale,
        'dataRientro': '',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Some error occurred $e');
    }
  }

  //! UPDATE TERRITORI COMMERCIALI
  static Future updateRiconsegnaCommerciali(String dataAttuale, String? lettera,
      String? fratello, String? dataUscita, String? id) async {
    final elencoAssegnazioneCollection =
        elencoAssegnazione.doc(lettera).collection('Elenco');
    final docRef = territoriCollection.doc(lettera);
    final newTerritorioCommerciale = TerritorioCommercialeModel(
            fratelloInPossesso: 'Proclamatore in possesso',
            dataLimite: 'Data Limite',
            dataUscita: 'Data Uscita',
            isDisponibile: true,
            dataRientro: dataAttuale,
            isNormale: false,
            lettera: lettera,
            id: id,
            timestamp: FieldValue.serverTimestamp())
        .toJson();
    final docRef2 = elencoAssegnazioneCollection.doc(id);

    try {
      await docRef.update(newTerritorioCommerciale);
      await docRef2.update({
        'id': id,
        'fratelloInPossesso': fratello,
        'dataRientro': dataAttuale,
        'dataUscita': dataUscita,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Some error occurred $e');
    }
  }

  static Future updateAffidaCommerciali(
      String dataAttuale, String? lettera, String fratello) async {
    final String dataRientroFormat;
    DateTime now = DateTime.now();

    DateTime dataRientro;
    dataRientro = now.add(const Duration(days: 120));
    dataRientroFormat =
        '${dataRientro.day}/${dataRientro.month}/${dataRientro.year}';

    final docRef = territoriCollection.doc(lettera);
    final elencoAssegnazioneCollection =
        elencoAssegnazione.doc(lettera).collection('Elenco');

    final docRef2 = elencoAssegnazioneCollection.doc();
    final newTerritorioCommerciale = TerritorioCommercialeModel(
            fratelloInPossesso: fratello,
            dataLimite: dataRientroFormat,
            dataUscita: dataAttuale,
            isDisponibile: false,
            dataRientro: 'Data Rientro',
            isNormale: false,
            lettera: lettera,
            id: docRef2.id,
            timestamp: FieldValue.serverTimestamp())
        .toJson();

    try {
      await docRef.update(newTerritorioCommerciale);
      await docRef2.set({
        'id': docRef2.id,
        'fratelloInPossesso': fratello,
        'dataUscita': dataAttuale,
        'dataRientro': '',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Some error occurred $e');
    }
  }

  //! READ ELENCO REGISTRO TERRITORI NORMALI
  static Stream<List<CardRegistroNormaleModel>> readElencoRegistroNormali(
      index) {
    final elencoAssegnazioneCollection = FirebaseFirestore.instance
        .collection('Registro')
        .doc(index.toString())
        .collection('Elenco')
        .orderBy('timestamp', descending: true);

    return elencoAssegnazioneCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((e) => CardRegistroNormaleModel.fromSnapshot(e))
            .toList());
  }

  //! READ ELENCO REGISTRO TERRITORI COMMERCIALI
  static Stream<List<CardRegistroCommercialeModel>>
      readElencoRegistroCommerciali(lettera) {
    final elencoAssegnazioneCollection = FirebaseFirestore.instance
        .collection('Registro')
        .doc(lettera)
        .collection('Elenco')
        .orderBy('timestamp', descending: true);

    return elencoAssegnazioneCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((e) => CardRegistroCommercialeModel.fromSnapshot(e))
            .toList());
  }

  //! DELETE VOCE REGISTRO NORMALI
  static Future deleteElementoRegistro(
      String idElemento, String numeroTerritorio) async {
    await elencoAssegnazione
        .doc(numeroTerritorio)
        .collection('Elenco')
        .doc(idElemento)
        .delete();
  }
}
