import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jw_territori/models/cardRegistroCommercialeModel.dart';

class ElencoRegistroCommercialeCard extends StatefulWidget {
  ElencoRegistroCommercialeCard(
      {super.key, required this.cardRegistroCommerciale});

  CardRegistroCommercialeModel cardRegistroCommerciale;
  @override
  State<ElencoRegistroCommercialeCard> createState() =>
      _ElencoRegistroCommercialeCardState();
}

class _ElencoRegistroCommercialeCardState
    extends State<ElencoRegistroCommercialeCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    );
  }
}
