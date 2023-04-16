import 'package:flutter/material.dart';

import '../pages/dettagliTerritorio.dart';

class TerritorioNorm extends StatefulWidget {
  TerritorioNorm({super.key, required this.index});

  int index;

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
                  widget.index.toString(),
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
                  children: const [
                    Text('Informazioni'),
                    SizedBox(
                      height: 6,
                    ),
                    Text('Fratello in possesso'),
                    SizedBox(
                      height: 6,
                    ),
                    Text('xx/yy/zzzz'),
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
                        builder: (context) => const DettagliTerritorio()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
