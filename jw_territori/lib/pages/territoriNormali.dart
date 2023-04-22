// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jw_territori/models/territorioNormaleModel.dart';
import 'package:jw_territori/services/firestoreHelper.dart';
import 'package:jw_territori/widgets/territorioNorm.dart';

class TerritoriNormali extends StatefulWidget {
  const TerritoriNormali({super.key});

  @override
  State<TerritoriNormali> createState() => _TerritoriNormaliState();
}

class _TerritoriNormaliState extends State<TerritoriNormali> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF5A2D81),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            indicatorWeight: 3,
            tabs: [
              Tab(
                text: 'Tutti',
              ),
              Tab(
                text: 'Disponibili',
              ),
              Tab(
                text: 'Non disponibili',
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<List<TerritorioNormaleModel>>(
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

                    return Expanded(
                      child: TabBarView(children: [
                        ListView.builder(
                            itemCount: territoriNormaliData!.length,
                            itemBuilder: (context, index) {
                              final singleTerritorioNormale =
                                  territoriNormaliData[index];
                              return TerritorioNorm(
                                territorioNormale: singleTerritorioNormale,
                              );
                            }),
                        ListView.builder(
                            itemCount: territoriNormaliData.length,
                            itemBuilder: (context, index) {
                              final singleTerritorioNormale =
                                  territoriNormaliData[index];
                              return TerritorioNorm(
                                territorioNormale: singleTerritorioNormale,
                              );
                            }),
                        ListView.builder(
                            itemCount: territoriNormaliData.length,
                            itemBuilder: (context, index) {
                              final singleTerritorioNormale =
                                  territoriNormaliData[index];
                              return TerritorioNorm(
                                territorioNormale: singleTerritorioNormale,
                              );
                            }),
                      ]),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                })
          ],
        ),
      ),
    );
  }
}
