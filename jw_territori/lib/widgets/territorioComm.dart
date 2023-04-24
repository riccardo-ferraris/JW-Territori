import 'package:flutter/material.dart';

import '../models/territorioCommercialeModel.dart';
import '../pages/dettagliTerritorioCommerciale.dart';

class TerritorioComm extends StatefulWidget {
  TerritorioComm({super.key, required this.territorioCommerciale});

  TerritorioCommercialeModel territorioCommerciale;

  @override
  State<TerritorioComm> createState() => _TerritorioCommState();
}

class _TerritorioCommState extends State<TerritorioComm> {
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
                  '${widget.territorioCommerciale.lettera}',
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
                      '${widget.territorioCommerciale.fratelloInPossesso}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          '${widget.territorioCommerciale.dataUscita}',
                        ),
                        const SizedBox(
                          width: 80,
                        ),
                        Text('${widget.territorioCommerciale.dataLimite}'),
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
                        builder: (context) => DettagliTerritorioCommerciale(
                              territorioCommerciale:
                                  widget.territorioCommerciale,
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
