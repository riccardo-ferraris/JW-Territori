// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jw_territori/models/territorioNormaleModel.dart';
import 'package:jw_territori/pages/territoriNormali.dart';
import 'package:jw_territori/services/firestoreHelper.dart';

import '../services/date_parser.dart';

class DettagliTerritorioNormale extends StatefulWidget {
  DettagliTerritorioNormale({super.key, required this.territorioNormale});

  TerritorioNormaleModel territorioNormale;

  @override
  State<DettagliTerritorioNormale> createState() =>
      _DettagliTerritorioNormaleState();
}

class _DettagliTerritorioNormaleState extends State<DettagliTerritorioNormale> {
  bool isAssigned = true;

  final controllerFratello = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A2D81),
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
                Text(
                  "Territorio n° ${widget.territorioNormale.numero}",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Card(
                  elevation: 8,
                  clipBehavior: Clip.hardEdge,
                  color: const Color.fromARGB(255, 226, 226, 226),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      side: BorderSide(color: Colors.black)),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/territori/territorio ${widget.territorioNormale.numero}.jpg',
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.territorioNormale.isDisponibile == !isAssigned
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
                                              '  ${widget.territorioNormale.fratelloInPossesso}',
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
                                                  '  ${widget.territorioNormale.dataUscita}',
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
                                                  '  ${widget.territorioNormale.dataLimite}',
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
                                              '  ${widget.territorioNormale.dataRientro}',
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
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                widget.territorioNormale.isDisponibile == !isAssigned
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
                                        setState(() {
                                          isAssigned = !isAssigned;

                                          DateTime now = DateTime.now();
                                          String dataString =
                                              '${now.day}/${now.month}/${now.year}';

                                          FirestoreHelper
                                              .updateRiconsegnaNormali(
                                                  dataString,
                                                  widget
                                                      .territorioNormale.numero,
                                                  widget.territorioNormale
                                                      .fratelloInPossesso,
                                                  widget.territorioNormale
                                                      .dataUscita,
                                                  widget.territorioNormale.id);

                                          Navigator.pushNamedAndRemoveUntil(
                                              context, '/', (_) => false);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const TerritoriNormali()));
                                        });
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
                                                    fontSize: 20))),
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                isAssigned = !isAssigned;

                                                DateTime now = DateTime.now();
                                                String dataString =
                                                    '${now.day}/${now.month}/${now.year}';

                                                FirestoreHelper
                                                    .updateAffidaNormali(
                                                        dataString,
                                                        widget.territorioNormale
                                                            .numero,
                                                        controllerFratello
                                                            .text);
                                              });
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context, '/', (_) => false);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const TerritoriNormali()));
                                            },
                                            child: const Text('Si',
                                                style: TextStyle(
                                                    color: Color(0xFF5A2D81),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20))),
                                      ],
                                    );
                                  });
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
