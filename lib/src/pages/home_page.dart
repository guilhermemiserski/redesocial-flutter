import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference _publicacoes =
      FirebaseFirestore.instance.collection('publicacoes');
  String post = '';
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          TextButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              child: const Text('Settings')),
          TextButton(
              onPressed: () => Navigator.pushNamed(context, '/profile'),
              child: const Text('Profile')),
        ]),
      ),
      body: Center(
        child: Column(children: [
          Text(
            user.email!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Sair')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: myController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Escreva seu post...',
                  contentPadding: EdgeInsets.all(8.0)),
            ),
          ),
          const SizedBox(
            height: 20,
            width: 20,
          ),
          ElevatedButton(
              onPressed: () {
                post = myController.text;
                _adicionarBD();
                myController.clear();
              },
              child: const Icon(Icons.add)),
          const SizedBox(
            height: 20,
            width: 20,
          ),
          Expanded(child: _buildPosts())
        ]),
      ),
    );
  }

  _adicionarBD() async {
    await _publicacoes.add({'post': post, 'user': user.email});
  }

  _deletarBD(String id) async {
    await _publicacoes.doc(id).delete();
  }

  _buildPosts() {
    return StreamBuilder(
      stream: _publicacoes.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(documentSnapshot['post']),
                  subtitle: Text(documentSnapshot['user']),
                  trailing: SizedBox(
                    width: 50,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            if (documentSnapshot['user'] == user.email) {
                              _deletarBD(documentSnapshot.id);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
