import 'package:cloud_firestore/cloud_firestore.dart';

class TerritorioNormaleModel {
  final String? fratelloInPossesso;
  final String? dataLimite;
  final String? dataRientro;
  final String? dataUscita;
  final bool? isDisponibile;
  final bool? isNormale;
  final int? numero;

  TerritorioNormaleModel(
      {this.dataUscita,
      this.isDisponibile,
      this.isNormale,
      this.numero,
      this.fratelloInPossesso,
      this.dataLimite,
      this.dataRientro});

  factory TerritorioNormaleModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return TerritorioNormaleModel(
      fratelloInPossesso: snapshot['fratelloInPossesso'],
      dataLimite: snapshot['dataLimite'],
      dataRientro: snapshot['dataRientro'],
      dataUscita: snapshot['dataUscita'],
      isDisponibile: snapshot['isDisponibile'],
      isNormale: snapshot['isNormale'],
      numero: snapshot['numero'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fratelloInPossesso': fratelloInPossesso,
        'dataLimite': dataLimite,
        'dataRientro': dataRientro,
        'dataUscita': dataUscita,
        'isDisponibile': isDisponibile,
        'isNormale': isNormale,
        'numero': numero,
      };
}
