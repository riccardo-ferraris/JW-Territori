// ignore: file_names
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
              // !TODO: Creare l'interruzione di sessione
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
                  color: Color.fromARGB(255, 226, 226, 226),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/territorio 22.jpg',
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      isAssigned
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Fratello in possesso',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
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
                                  Text(
                                    'Data di rientro',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (isAssigned)
                                    Text(
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
                SizedBox(
                  height: 30,
                ),
                isAssigned
                    ? TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          elevation: MaterialStateProperty.all(5),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(20)),
                        ),
                        onPressed: () {
                          setState(() {
                            isAssigned = !isAssigned;
                          });
                        },
                        child: Text(
                          'Riconsegna',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    : Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
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
                          SizedBox(
                            height: 30,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                              elevation: MaterialStateProperty.all(5),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(20)),
                            ),
                            onPressed: () {
                              setState(() {
                                isAssigned = !isAssigned;
                              });
                            },
                            child: Text(
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
