// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jw_territori/models/card_registro_commerciale_model.dart';

import '../services/firestore_helper.dart';

class ElencoRegistroCommercialeCard extends StatefulWidget {
  ElencoRegistroCommercialeCard({
    super.key,
    required this.cardRegistroCommerciale,
    required this.lettera,
  });

  CardRegistroCommercialeModel cardRegistroCommerciale;
  String lettera;

  @override
  State<ElencoRegistroCommercialeCard> createState() =>
      _ElencoRegistroCommercialeCardState();
}

class _ElencoRegistroCommercialeCardState
    extends State<ElencoRegistroCommercialeCard> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
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
                              widget.cardRegistroCommerciale.id!,
                              widget.lettera);

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
      ]),
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
                  '${widget.cardRegistroCommerciale.fratelloInPossesso}',
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
                        '${widget.cardRegistroCommerciale.dataUscita}',
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
                        '${widget.cardRegistroCommerciale.dataRientro}',
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
