import 'package:flutter/material.dart';
import 'package:jw_territori/pages/dettagliNormaliRegistro.dart';

class ElencoNormaliRegistro extends StatefulWidget {
  ElencoNormaliRegistro({super.key, required this.index});

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
            '${widget.index}',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
