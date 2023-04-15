// ignore: file_names
import 'package:flutter/material.dart';
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
                // !TODO: Creare l'interruzione di sessione
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(children: [
                ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return TerritorioComm(index: index + 65);
                    }),
                ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return TerritorioComm(index: index + 65);
                    }),
                ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return TerritorioComm(index: index + 65);
                    }),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
