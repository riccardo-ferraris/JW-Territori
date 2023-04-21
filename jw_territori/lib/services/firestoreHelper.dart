import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jw_territori/models/territorioNormaleModel.dart';

import '../models/territorioCommercialeModel.dart';

class FirestoreHelper {
  static Stream<List<TerritorioNormaleModel>> read() {
    final territoriNormaliCollection =
        FirebaseFirestore.instance.collection('"Territori"').orderBy('numero');
    return territoriNormaliCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((e) => TerritorioNormaleModel.fromSnapshot(e))
            .toList());
  }

  static Stream<List<TerritorioCommercialeModel>> readComm() {
    final territoriCommercialiCollection =
        FirebaseFirestore.instance.collection('"Territori"').orderBy('lettera');
    return territoriCommercialiCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((e) => TerritorioCommercialeModel.fromSnapshot(e))
            .toList());
  }

  static Stream<List<TerritorioNormaleModel>> readDisponibili() {
    final territoriNormaliCollection = FirebaseFirestore.instance
        .collection('"Territori"')
        .orderBy('isDisponibile');
    return territoriNormaliCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((e) => TerritorioNormaleModel.fromSnapshot(e))
            .toList());
  }
}
