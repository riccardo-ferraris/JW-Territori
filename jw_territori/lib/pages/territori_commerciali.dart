// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jw_territori/services/firestore_helper.dart';
import 'package:jw_territori/widgets/territorio_comm.dart';

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
          title: const Text('Commerciali'),
          backgroundColor: const Color(0xFF5A2D81),
          foregroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            labelStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.grey[500],
            indicatorWeight: 3,
            tabs: const [
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
            // ? IconButton(onPressed: () {}, icon: const Icon(Icons.list)),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        body: TabBarView(children: [
          TerritoriCommercialiListView(
            stream: FirestoreHelper.readAllCommerciali(),
            errorMessage:
                'Errore nel caricamento di tutti i territori commerciali!',
          ),
          TerritoriCommercialiListView(
            stream: FirestoreHelper.readCommercialiDisponibili(),
            errorMessage:
                'Errore nel caricamento dei territori commerciali disponibili!',
          ),
          NonDisponibiliTerritoriCommercialiListView(),
        ]),
      ),
    );
  }
}

class TerritoriCommercialiListView extends StatelessWidget {
  final Stream<List> stream;
  final String errorMessage;

  const TerritoriCommercialiListView({
    super.key,
    required this.stream,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(errorMessage),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Nessun dato disponibile'),
          );
        }
        final territoriCommercialiData = snapshot.data!;
        return ListView.builder(
          itemCount: territoriCommercialiData.length,
          itemBuilder: (context, index) {
            final singleTerritorioCommerciale = territoriCommercialiData[index];
            return TerritorioComm(
              territorioCommerciale: singleTerritorioCommerciale,
            );
          },
        );
      },
    );
  }
}

class NonDisponibiliTerritoriCommercialiListView extends StatefulWidget {
  @override
  _NonDisponibiliTerritoriCommercialiListView createState() =>
      _NonDisponibiliTerritoriCommercialiListView();
}

class _NonDisponibiliTerritoriCommercialiListView
    extends State<NonDisponibiliTerritoriCommercialiListView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  List _filteredData = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Cerca per nome',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: FirestoreHelper.readCommercialiNonDisponibili(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Si è verificato un errore!'),
                );
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Nessun dato disponibile'),
                );
              }
              final territoriCommercialiData = snapshot.data!;
              _filteredData = _searchText.isEmpty
                  ? territoriCommercialiData
                  : territoriCommercialiData.where((territorio) {
                      final name =
                          territorio.fratelloInPossesso?.toLowerCase() ?? '';
                      final query = _searchText.toLowerCase();
                      return name.contains(query);
                    }).toList();

              return ListView.builder(
                itemCount: _filteredData.length,
                itemBuilder: (context, index) {
                  final singleTerritorioCommerciale = _filteredData[index];
                  return TerritorioComm(
                    territorioCommerciale: singleTerritorioCommerciale,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
