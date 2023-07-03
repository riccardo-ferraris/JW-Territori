import 'package:cloud_firestore/cloud_firestore.dart';

class CardRegistroCommercialeModel {
  final String? fratelloInPossesso;
  final String? dataRientro;
  final String? dataUscita;
  final String? lettera;
  final String? id;

  CardRegistroCommercialeModel(
      {this.dataUscita,
      this.lettera,
      this.fratelloInPossesso,
      this.dataRientro,
      this.id});

  factory CardRegistroCommercialeModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CardRegistroCommercialeModel(
      fratelloInPossesso: snapshot['fratelloInPossesso'],
      dataRientro: snapshot['dataRientro'],
      dataUscita: snapshot['dataUscita'],
      lettera: snapshot['lettera'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fratelloInPossesso': fratelloInPossesso,
        'dataRientro': dataRientro,
        'dataUscita': dataUscita,
        'lettera': lettera,
        'id': id,
      };
}
