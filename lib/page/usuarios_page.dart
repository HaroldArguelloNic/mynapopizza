import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mynapopizza/services/firebase_service.dart';


class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
      ),
      body: FutureBuilder (
        future: getUsuarios(),
        builder: ((context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context,index) {
                return Text(snapshot.data?[index]['nombre']);
              },
            );

          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
            
        }),
 
      ),
    );
  }
}