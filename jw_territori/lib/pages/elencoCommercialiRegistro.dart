import 'package:flutter/material.dart';
import 'package:jw_territori/models/territorioCommercialeModel.dart';

import 'dettagliCommercialiRegistro.dart';

class ElencoCommercialiRegistro extends StatefulWidget {
  ElencoCommercialiRegistro(
      {super.key, required this.index, required this.territorioCommerciale});

  TerritorioCommercialeModel territorioCommerciale;
  int index;

  @override
  State<ElencoCommercialiRegistro> createState() =>
      _ElencoCommercialiRegistroState();
}

class _ElencoCommercialiRegistroState extends State<ElencoCommercialiRegistro> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DettagliCommercialiRegistro(
                      index: widget.index,
                      territorioCommerciale: widget.territorioCommerciale,
                    )));
      },
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: const EdgeInsets.all(8),
        elevation: 6,
        child: Center(
          child: Text(
            '${widget.territorioCommerciale.lettera}',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
