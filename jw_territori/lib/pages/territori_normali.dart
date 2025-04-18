import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jw_territori/services/firestore_helper.dart';
import 'package:jw_territori/widgets/territorio_norm.dart';

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
          title: const Text('Residenziali'),
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
              Tab(text: 'Tutti'),
              Tab(text: 'Disponibili'),
              Tab(text: 'Non disponibili'),
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
        body: TabBarView(children: [
          TerritoriNormaliListView(
            stream: FirestoreHelper.readAllNormali(),
            errorMessage:
                'Errore nel caricamento di tutti i territori residenziali!',
          ),
          TerritoriNormaliListView(
            stream: FirestoreHelper.readNormaliDisponibili(),
            errorMessage:
                'Errore nel caricamento dei territori residenziali disponibili!',
          ),
          NonDisponibiliTerritoriNormaliListView(),
        ]),
      ),
    );
  }
}

class TerritoriNormaliListView extends StatelessWidget {
  final Stream<List> stream;
  final String errorMessage;

  const TerritoriNormaliListView({
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
        final territoriNormaliData = snapshot.data!;
        return ListView.builder(
          itemCount: territoriNormaliData.length,
          itemBuilder: (context, index) {
            final singleTerritorioNormale = territoriNormaliData[index];
            return TerritorioNorm(
              territorioNormale: singleTerritorioNormale,
            );
          },
        );
      },
    );
  }
}

class NonDisponibiliTerritoriNormaliListView extends StatefulWidget {
  @override
  _NonDisponibiliTerritoriNormaliListViewState createState() =>
      _NonDisponibiliTerritoriNormaliListViewState();
}

class _NonDisponibiliTerritoriNormaliListViewState
    extends State<NonDisponibiliTerritoriNormaliListView> {
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
            stream: FirestoreHelper.readNormaliNonDisponibili(),
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
              final territoriNormaliData = snapshot.data!;
              _filteredData = _searchText.isEmpty
                  ? territoriNormaliData
                  : territoriNormaliData.where((territorio) {
                      final name =
                          territorio.fratelloInPossesso?.toLowerCase() ?? '';
                      final query = _searchText.toLowerCase();
                      return name.contains(query);
                    }).toList();

              return ListView.builder(
                itemCount: _filteredData.length,
                itemBuilder: (context, index) {
                  final singleTerritorioNormale = _filteredData[index];
                  return TerritorioNorm(
                    territorioNormale: singleTerritorioNormale,
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
