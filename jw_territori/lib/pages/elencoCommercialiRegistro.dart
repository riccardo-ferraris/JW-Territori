import 'package:flutter/material.dart';

import 'dettagliCommercialiRegistro.dart';
import 'dettagliNormaliRegistro.dart';

class ElencoCommercialiRegistro extends StatefulWidget {
  ElencoCommercialiRegistro({super.key, required this.index});

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
                builder: (context) =>
                    DettagliCommercialiRegistro(index: widget.index)));
      },
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: const EdgeInsets.all(8),
        elevation: 6,
        child: Center(
          child: Text(
            String.fromCharCode((widget.index + 64)),
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
