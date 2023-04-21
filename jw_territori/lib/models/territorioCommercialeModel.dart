import 'package:cloud_firestore/cloud_firestore.dart';

class TerritorioCommercialeModel {
  final String? fratelloInPossesso;
  final String? dataLimite;
  final String? dataRientro;
  final String? dataUscita;
  final bool? isDisponibile;
  final bool? isNormale;
  final String? lettera;

  TerritorioCommercialeModel(
      {this.dataUscita,
      this.isDisponibile,
      this.isNormale,
      this.lettera,
      this.fratelloInPossesso,
      this.dataLimite,
      this.dataRientro});

  factory TerritorioCommercialeModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return TerritorioCommercialeModel(
      fratelloInPossesso: snapshot['fratelloInPossesso'],
      dataLimite: snapshot['dataLimite'],
      dataRientro: snapshot['dataRientro'],
      dataUscita: snapshot['dataUscita'],
      isDisponibile: snapshot['isDisponibile'],
      isNormale: snapshot['isNormale'],
      lettera: snapshot['lettera'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fratelloInPossesso': fratelloInPossesso,
        'dataLimite': dataLimite,
        'dataRientro': dataRientro,
        'dataUscita': dataUscita,
        'isDisponibile': isDisponibile,
        'isNormale': isNormale,
        'lettera': lettera,
      };
}
