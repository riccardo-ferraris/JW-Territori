// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jw_territori/models/card_registro_normale_model.dart';
import 'package:jw_territori/services/firestore_helper.dart';

class ElencoRegistroNormaleCard extends StatefulWidget {
  ElencoRegistroNormaleCard(
      {super.key, required this.cardRegistroNormale, required this.index});

  CardRegistroNormaleModel cardRegistroNormale;
  int index;
  @override
  State<ElencoRegistroNormaleCard> createState() =>
      _ElencoRegistroNormaleCardState();
}

class _ElencoRegistroNormaleCardState extends State<ElencoRegistroNormaleCard> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Sei sicuro?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No',
                              style: TextStyle(
                                  color: Color(0xFF5A2D81),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                        TextButton(
                          onPressed: () {
                            FirestoreHelper.deleteElementoRegistro(
                                widget.cardRegistroNormale.id!,
                                widget.index.toString());

                            Navigator.pop(context);
                          },
                          child: const Text('Si',
                              style: TextStyle(
                                  color: Color(0xFF5A2D81),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                      ],
                    );
                  });
            },
            icon: Icons.delete,
            backgroundColor: Colors.red,
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Assegnato a:',
                    style: TextStyle(
                      fontSize: 14,
                    )),
                Center(
                    child: Text(
                  '${widget.cardRegistroNormale.fratelloInPossesso}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Data Uscita:',
                          style: TextStyle(
                            fontSize: 14,
                          )),
                      Center(
                          child: Text(
                        '${widget.cardRegistroNormale.dataUscita}',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Data Rientro:',
                          style: TextStyle(
                            fontSize: 14,
                          )),
                      Center(
                          child: Text(
                        '${widget.cardRegistroNormale.dataRientro}',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
