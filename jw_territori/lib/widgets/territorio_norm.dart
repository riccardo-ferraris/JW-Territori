// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jw_territori/models/territorio_normale_model.dart';
import '../pages/dettagli_territorio_normale.dart';
import '../services/date_parser.dart';

class TerritorioNorm extends StatefulWidget {
  TerritorioNorm({super.key, required this.territorioNormale});

  TerritorioNormaleModel territorioNormale;

  @override
  State<TerritorioNorm> createState() => _TerritorioNormState();
}

class _TerritorioNormState extends State<TerritorioNorm> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.territorioNormale.dataUscita != 'Data Uscita' &&
              widget.territorioNormale.dataLimite != 'Data Limite'
          ? MyDateParser.cardColorFromDate(
              MyDateParser.dateInverter(widget.territorioNormale.dataLimite!),
            )
          : null,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: const EdgeInsets.all(8),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '${widget.territorioNormale.numero}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                widget.territorioNormale.isDisponibile == false
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.territorioNormale.fratelloInPossesso}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                '${widget.territorioNormale.dataUscita}',
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              Text('${widget.territorioNormale.dataLimite}'),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Disponibile',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                              'Ultimo rientro: ${widget.territorioNormale.dataRientro}'),
                        ],
                      ),
              ],
            ),
            GestureDetector(
              child: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DettagliTerritorioNormale(
                              territorioNormale: widget.territorioNormale,
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
