// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jw_territori/models/territorioNormaleModel.dart';
import 'package:jw_territori/services/firestoreHelper.dart';

class DettagliTerritorio extends StatefulWidget {
  DettagliTerritorio({super.key, required this.territorioNormale});

  TerritorioNormaleModel territorioNormale;

  @override
  State<DettagliTerritorio> createState() => _DettagliTerritorioState();
}

class _DettagliTerritorioState extends State<DettagliTerritorio> {
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
                      Image.asset(
                        'images/territori/territorio ${widget.territorioNormale.numero}.jpg',
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      isAssigned //? --------------------------------------------------------------------------------
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text(
                                    '${widget.territorioNormale.fratelloInPossesso}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${widget.territorioNormale.dataUscita}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${widget.territorioNormale.dataLimite}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
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
                                  Text(
                                    '${widget.territorioNormale.dataRientro}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (isAssigned) //? --------------------------------------------------------------------------------
                                    Text(
                                      '${widget.territorioNormale.dataLimite}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
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
                isAssigned //? --------------------------------------------------------------------------------
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
                                          isAssigned =
                                              !isAssigned; //? -----------------------------------------------------------------

                                          DateTime now = DateTime.now();
                                          String dataString =
                                              '${now.day}/${now.month}/${now.year}';

                                          FirestoreHelper
                                              .updateRiconsegnaNormali(
                                                  dataString,
                                                  widget.territorioNormale
                                                      .numero);
                                        });
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
                                  "Fratello a cui assegnare il territorio",
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
                                            child: const Text('No')),
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                isAssigned =
                                                    !isAssigned; //? --------------------------------------------------------------

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
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Si')),
                                      ],
                                    );
                                  });
                            },
                            child: const Text(
                              'Affida',
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
