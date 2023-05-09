import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jw_territori/models/territorioNormaleModel.dart';

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
    } else if (FirebaseAuth.instance.currentUser!.email!
        .contains('caracciolo')) {
      return 'Francesco Caracciolo';
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
            id: id)
        .toJson();
    final docRef2 = elencoAssegnazioneCollection.doc(id);
    try {
      await docRef.update(newTerritorioNormale);
      await docRef2.update({
        'id': id,
        'fratelloInPossesso': fratello,
        'dataRientro': dataAttuale,
        'dataUscita': dataUscita,
      });
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
    ).toJson();

    try {
      await docRef.update(newTerritorioNormale);
      await docRef2.set({
        'id': docRef2.id,
        'fratelloInPossesso': fratello,
        'dataUscita': dataAttuale,
        'dataRientro': '',
      });
    } catch (e) {
      print('Some error occurred $e');
    }
  }

  //! UPDATE TERRITORI COMMERCIALI
  static Future updateRiconsegnaCommerciali(
      String dataAttuale, String? lettera) async {
    final docRef = territoriCollection.doc(lettera);
    final newTerritorioCommerciale = TerritorioCommercialeModel(
            fratelloInPossesso: 'Proclamatore in possesso',
            dataLimite: 'Data Limite',
            dataUscita: 'Data Uscita',
            isDisponibile: true,
            dataRientro: dataAttuale,
            isNormale: false,
            lettera: lettera)
        .toJson();

    try {
      await docRef.update(newTerritorioCommerciale);
    } catch (e) {
      print('Some error occurred $e');
    }
  }

  static Future updateAffidaCommerciali(
      String dataAttuale, String? lettera, String fratello) async {
    final String dataRientroFormat;
    DateTime now = DateTime.now();
    if (now.month + 4 > 12) {
      dataRientroFormat = '${now.day}/${now.month - 8}/${now.year + 1}';
    } else {
      dataRientroFormat = '${now.day}/${now.month + 4}/${now.year}';
    }

    final docRef = territoriCollection.doc(lettera);
    final newTerritorioCommerciale = TerritorioCommercialeModel(
            fratelloInPossesso: fratello,
            dataLimite: dataRientroFormat,
            dataUscita: dataAttuale,
            isDisponibile: false,
            dataRientro: 'Data Rientro',
            isNormale: false,
            lettera: lettera)
        .toJson();

    try {
      await docRef.update(newTerritorioCommerciale);
    } catch (e) {
      print('Some error occurred $e');
    }
  }
}
