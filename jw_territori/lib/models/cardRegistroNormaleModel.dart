import 'package:cloud_firestore/cloud_firestore.dart';

class CardRegistroNormaleModel {
  final String? fratelloInPossesso;
  final String? dataRientro;
  final String? dataUscita;
  final int? numero;
  final String? id;

  CardRegistroNormaleModel(
      {this.dataUscita,
      this.numero,
      this.fratelloInPossesso,
      this.dataRientro,
      this.id});

  factory CardRegistroNormaleModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CardRegistroNormaleModel(
      fratelloInPossesso: snapshot['fratelloInPossesso'],
      dataRientro: snapshot['dataRientro'],
      dataUscita: snapshot['dataUscita'],
      numero: snapshot['numero'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fratelloInPossesso': fratelloInPossesso,
        'dataRientro': dataRientro,
        'dataUscita': dataUscita,
        'numero': numero,
        'id': id,
      };
}
