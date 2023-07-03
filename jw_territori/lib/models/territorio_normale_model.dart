import 'package:cloud_firestore/cloud_firestore.dart';

class TerritorioNormaleModel {
  final String? fratelloInPossesso;
  final String? dataLimite;
  final String? dataRientro;
  final String? dataUscita;
  final bool? isDisponibile;
  final bool? isNormale;
  final int? numero;
  final String? id;
  final dynamic timestamp;

  TerritorioNormaleModel(
      {this.dataUscita,
      this.isDisponibile,
      this.isNormale,
      this.numero,
      this.fratelloInPossesso,
      this.dataLimite,
      this.dataRientro,
      this.id,
      this.timestamp});

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
        id: snapshot['id'],
        timestamp: snapshot['timestamp']);
  }

  Map<String, dynamic> toJson() => {
        'fratelloInPossesso': fratelloInPossesso,
        'dataLimite': dataLimite,
        'dataRientro': dataRientro,
        'dataUscita': dataUscita,
        'isDisponibile': isDisponibile,
        'isNormale': isNormale,
        'numero': numero,
        'id': id,
        'timestamp': timestamp,
      };
}
