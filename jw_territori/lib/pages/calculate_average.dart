import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jw_territori/services/firestoreHelper.dart';

class CalculateAverage extends StatelessWidget {
  const CalculateAverage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcolo Media'),
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
      body: const Center(
          // child: Text(
          //   'Media: ',
          //   style: TextStyle(fontSize: 40),
          // ),

          ),
    );
  }
}
