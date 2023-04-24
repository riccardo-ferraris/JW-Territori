import 'package:flutter/material.dart';
import 'package:jw_territori/models/territorioNormaleModel.dart';

import '../pages/dettagliTerritorioNormale.dart';

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
                Column(
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
