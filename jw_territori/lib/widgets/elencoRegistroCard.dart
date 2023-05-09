import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ElencoRegistroCard extends StatefulWidget {
  const ElencoRegistroCard({super.key});

  @override
  State<ElencoRegistroCard> createState() => _ElencoRegistroCardState();
}

class _ElencoRegistroCardState extends State<ElencoRegistroCard> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            showDialog(
              context: context,
              builder: ((context) {
                return AlertDialog(
                  title: const Text('Sei sicuro?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(
                            color: Color(0xFF5A2D81),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //!TODO Implementare l'eliminazione di una voce nel registro
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Si',
                        style: TextStyle(
                            color: Color(0xFF5A2D81),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ],
                );
              }),
            );
          },
          icon: Icons.delete,
          label: 'Elimina',
          backgroundColor: Colors.red,
        ),
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
                        style: TextStyle(
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
                    children: const [
                      Text('Data Rientro:',
                          style: TextStyle(
                            fontSize: 14,
                          )),
                      Center(
                          child: Text(
                        '29/04/2023',
                        style: TextStyle(
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
