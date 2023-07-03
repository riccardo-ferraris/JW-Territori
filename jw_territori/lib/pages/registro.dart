import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jw_territori/pages/calculate_average.dart';
import 'package:jw_territori/pages/elenco_normali_registro.dart';
import 'package:jw_territori/services/firestore_helper.dart';

import 'elenco_commerciali_registro.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registro'),
          backgroundColor: const Color(0xFF5A2D81),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            indicatorWeight: 3,
            tabs: [
              Tab(
                text: 'Residenziali',
              ),
              Tab(
                text: 'Commerciali',
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // FirestoreHelper.counterTerritoriPerMedia();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CalculateAverage(),
                    ),
                  );
                },
                icon: const Icon(Icons.calculate)),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            StreamBuilder(
                stream: FirestoreHelper.readAllNormali(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Some error occurred!'),
                    );
                  }
                  if (snapshot.hasData) {
                    final territoriNormaliData = snapshot.data;
                    return GridView.builder(
                      itemCount: territoriNormaliData!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final singleTerritorioNormale =
                            territoriNormaliData[index];
                        return ElencoNormaliRegistro(
                          index: ++index,
                          territorioNormale: singleTerritorioNormale,
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            StreamBuilder(
                stream: FirestoreHelper.readAllCommerciali(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Some error occurred!'),
                    );
                  }
                  if (snapshot.hasData) {
                    final territoriCommercialiData = snapshot.data;
                    return GridView.builder(
                      itemCount: territoriCommercialiData!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final singleTerritorioCommerciale =
                            territoriCommercialiData[index];
                        return ElencoCommercialiRegistro(
                          index: ++index,
                          territorioCommerciale: singleTerritorioCommerciale,
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
