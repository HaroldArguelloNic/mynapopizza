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
        leading: null,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getUsuarios(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Map<String, dynamic>> usuarios = snapshot.data ?? [];
            return ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                final usuario = usuarios[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person),
                    ),
                    title: Text(usuario['nombre'] ?? ''),
                    subtitle: Text(usuario['correoElectronico'] ?? ''),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
