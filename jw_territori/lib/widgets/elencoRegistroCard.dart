import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ElencoRegistroCard extends StatefulWidget {
  ElencoRegistroCard({super.key});

  @override
  State<ElencoRegistroCard> createState() => _ElencoRegistroCardState();
}

class _ElencoRegistroCardState extends State<ElencoRegistroCard> {
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
            children: const [
              Text('Assegnato a:',
                  style: TextStyle(
                    fontSize: 14,
                  )),
              Center(
                  child: Text(
                'Riccardo Ferraris',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  children: const [
                    Text('Data Uscita:',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    Center(
                        child: Text(
                      '29/04/2023',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
                  children: const [
                    Text('Data Rientro:',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    Center(
                        child: Text(
                      '29/04/2023',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
