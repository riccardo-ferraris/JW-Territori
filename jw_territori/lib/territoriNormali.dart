// ignore: file_names
import 'package:flutter/material.dart';
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
                    itemCount: 72,
                    itemBuilder: (context, index) {
                      return TerritorioNorm(index: ++index);
                    }),
                ListView.builder(
                    itemCount: 72,
                    itemBuilder: (context, index) {
                      return TerritorioNorm(index: ++index);
                    }),
                ListView.builder(
                    itemCount: 72,
                    itemBuilder: (context, index) {
                      return TerritorioNorm(index: ++index);
                    }),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
