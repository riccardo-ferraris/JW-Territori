// ignore: file_names
// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jw_territori/models/territorio_commerciale_model.dart';
import 'package:jw_territori/pages/territori_commerciali.dart';
import 'package:jw_territori/services/firestore_helper.dart';

class DettagliTerritorioCommerciale extends StatefulWidget {
  DettagliTerritorioCommerciale(
      {super.key, required this.territorioCommerciale});

  TerritorioCommercialeModel territorioCommerciale;

  @override
  State<DettagliTerritorioCommerciale> createState() =>
      _DettagliTerritorioCommercialeState();
}

class _DettagliTerritorioCommercialeState
    extends State<DettagliTerritorioCommerciale> {
  bool isAssigned = true;

  final controllerFratello = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A2D81),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Card(
                  elevation: 8,
                  clipBehavior: Clip.hardEdge,
                  color: const Color.fromARGB(255, 226, 226, 226),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      side: BorderSide(color: Colors.black)),
                  child: Column(
                    children: [
                      //!TODO aggiungere controllo per territori commerciali e implementare le immagini adatte

                      // Image.asset(
                      //   'images/territori/territorio ${widget.territorioCommerciale.numero}.jpg',
                      //   fit: BoxFit.fill,
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.territorioCommerciale.isDisponibile == !isAssigned
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Assegnato a: \n',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '  ${widget.territorioCommerciale.fratelloInPossesso}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Data di uscita\n',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '  ${widget.territorioCommerciale.dataUscita}',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Data limite\n',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '  ${widget.territorioCommerciale.dataLimite}',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Data rientro\n',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '  ${widget.territorioCommerciale.dataRientro}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                widget.territorioCommerciale.isDisponibile == !isAssigned
                    ? TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          elevation: MaterialStateProperty.all(5),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                        ),
                        onPressed: () {
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
                                        setState(
                                          () {
                                            isAssigned = !isAssigned;

                                            DateTime now = DateTime.now();
                                            String dataString =
                                                '${now.day}/${now.month}/${now.year}';
                                            FirestoreHelper
                                                .updateRiconsegnaCommerciali(
                                                    dataString,
                                                    widget.territorioCommerciale
                                                        .lettera,
                                                    widget.territorioCommerciale
                                                        .fratelloInPossesso,
                                                    widget.territorioCommerciale
                                                        .dataUscita,
                                                    widget.territorioCommerciale
                                                        .id);

                                            Navigator.pushNamedAndRemoveUntil(
                                                context, '/', (_) => false);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const TerritoriCommerciali()));
                                          },
                                        );
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
                        child: const Text(
                          'Riconsegna',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    : Column(
                        children: [
                          TextFormField(
                            controller: controllerFratello,
                            decoration: InputDecoration(
                              fillColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              filled: true,
                              hintText:
                                  "Proclamatore a cui assegnare il territorio",
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 95, 95, 95),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF5A2D81), width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF5A2D81), width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                              elevation: MaterialStateProperty.all(5),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(20)),
                            ),
                            onPressed: () {
                              if (controllerFratello.text != '') {
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20))),
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  isAssigned = !isAssigned;

                                                  DateTime now = DateTime.now();
                                                  String dataString =
                                                      '${now.day}/${now.month}/${now.year}';
                                                  FirestoreHelper
                                                      .updateAffidaCommerciali(
                                                          dataString,
                                                          widget
                                                              .territorioCommerciale
                                                              .lettera,
                                                          controllerFratello
                                                              .text);
                                                });
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        '/',
                                                        (_) => false);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const TerritoriCommerciali()));
                                              },
                                              child: const Text('Si',
                                                  style: TextStyle(
                                                      color: Color(0xFF5A2D81),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20))),
                                        ],
                                      );
                                    });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Inserisci il nome di un proclamatore.')));
                              }
                            },
                            child: const Text(
                              'Assegna',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
