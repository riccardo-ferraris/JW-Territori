// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jw_territori/models/territorioCommercialeModel.dart';
import 'package:jw_territori/services/firestoreHelper.dart';
import 'package:jw_territori/widgets/territorioComm.dart';

class TerritoriCommerciali extends StatefulWidget {
  const TerritoriCommerciali({super.key});

  @override
  State<TerritoriCommerciali> createState() => _TerritoriCommercialiState();
}

class _TerritoriCommercialiState extends State<TerritoriCommerciali> {
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
            StreamBuilder<List<TerritorioCommercialeModel>>(
                stream: FirestoreHelper.readCommercialiDisponibili(),
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

                    return Expanded(
                      child: TabBarView(children: [
                        ListView.builder(
                            itemCount: territoriCommercialiData!.length,
                            itemBuilder: (context, index) {
                              final singleTerritorioCommerciale =
                                  territoriCommercialiData[index];
                              return TerritorioComm(
                                territorioCommerciale:
                                    singleTerritorioCommerciale,
                              );
                            }),
                        ListView.builder(
                            itemCount: territoriCommercialiData.length,
                            itemBuilder: (context, index) {
                              final singleTerritorioCommerciale =
                                  territoriCommercialiData[index];
                              return TerritorioComm(
                                territorioCommerciale:
                                    singleTerritorioCommerciale,
                              );
                            }),
                        ListView.builder(
                            itemCount: territoriCommercialiData.length,
                            itemBuilder: (context, index) {
                              final singleTerritorioCommerciale =
                                  territoriCommercialiData[index];
                              return TerritorioComm(
                                territorioCommerciale:
                                    singleTerritorioCommerciale,
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
