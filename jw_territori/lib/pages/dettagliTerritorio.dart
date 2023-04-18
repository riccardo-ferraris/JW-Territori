// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DettagliTerritorio extends StatefulWidget {
  const DettagliTerritorio({super.key});

  @override
  State<DettagliTerritorio> createState() => _DettagliTerritorioState();
}

class _DettagliTerritorioState extends State<DettagliTerritorio> {
  bool isAssigned = true;

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
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/territorio 22.jpg',
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      isAssigned
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'Fratello in possesso',
                                    style: TextStyle(
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
                                    children: const [
                                      Text(
                                        'Data di uscita',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Data limite',
                                        style: TextStyle(
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
                                  const Text(
                                    'Data di rientro',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (isAssigned)
                                    const Text(
                                      'Data limite',
                                      style: TextStyle(
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
                isAssigned
                    ? TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          elevation: MaterialStateProperty.all(5),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                        ),
                        onPressed: () {
                          setState(() {
                            isAssigned = !isAssigned;
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
                              setState(() {
                                isAssigned = !isAssigned;
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
