import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynapopizza/utils/text_box.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
//user
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection('usuarios');
//edit field
  Future<void> editfield(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Edit $field',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: 'Entre el nuevo $field',
              hintStyle: const TextStyle(color: Colors.grey)),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // cancel button
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              )),
          //save button
          TextButton(
              onPressed: () => Navigator.of(context).pop(newValue),
              child: const Text(
                'Guardar',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
    //update in FIrestore
    if (newValue.trim().length > 0) {
      await usersCollection.doc(currentUser.uid).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[200],
        appBar: AppBar(
          title: const Text('Perfil de Usuario'),
          backgroundColor: Colors.orange[100],
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('usuarios')
                .doc(currentUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              //get userdata
              if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                return ListView(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),

                    //profile picture
                    CircleAvatar(
                      backgroundImage: NetworkImage(userData['image']),
                      radius: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //user email
                    Text(
                      currentUser.email.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700]),
                    ),

                    const SizedBox(
                      height: 50,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        "Mi Detalle",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //username

                    MyTextBox(
                      text: userData['name'],
                      sectionName: 'username',
                      onPressed: () => editfield('name'),
                    ),
                    MyTextBox(
                      text: userData['contrasenia'],
                      sectionName: 'contraseña',
                      onPressed: () => editfield('contrasenia'),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Eror${snapshot.error}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
