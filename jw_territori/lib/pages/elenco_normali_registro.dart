// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jw_territori/models/territorio_normale_model.dart';
import 'package:jw_territori/pages/dettagli_normali_registro.dart';

class ElencoNormaliRegistro extends StatefulWidget {
  ElencoNormaliRegistro(
      {super.key, required this.index, required this.territorioNormale});

  TerritorioNormaleModel territorioNormale;
  int index;

  @override
  State<ElencoNormaliRegistro> createState() => _ElencoNormaliRegistroState();
}

class _ElencoNormaliRegistroState extends State<ElencoNormaliRegistro> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DettagliNormaliRegistro(index: widget.index)));
      },
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: const EdgeInsets.all(8),
        elevation: 6,
        child: Center(
          child: Text(
            '${widget.territorioNormale.numero}',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
