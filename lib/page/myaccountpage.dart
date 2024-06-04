import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAccountPageState createState() => _MyAccountPageState();
}


class _MyAccountPageState extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil Usuario'),
      ),
      body: const MyAccountBody(),
    );
  }
}

class MyAccountBody extends StatelessWidget {
  const MyAccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/usuario.png'), // Cambia por tu propia imagen
          ),
          const SizedBox(height: 20),
          const Text(
            'Nombre de Usuario',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Correo electrónico: admin@admin.com', // Cambia por tu propia dirección de correo electrónico
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Acción al presionar el botón (por ejemplo, cerrar sesión)
            },
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }
}
