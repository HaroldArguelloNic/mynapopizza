import 'package:flutter/material.dart';
import 'package:mynapopizza/page/home_page.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil Usuario'),
      ),
      body: MyAccountBody(),
    );
  }
}

class MyAccountBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/usuario.png'), // Cambia por tu propia imagen
          ),
          SizedBox(height: 20),
          Text(
            'Nombre de Usuario',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Correo electrónico: admin@admin.com', // Cambia por tu propia dirección de correo electrónico
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Acción al presionar el botón (por ejemplo, cerrar sesión)
            },
            child: Text('Cerrar Sesión'),
          ),
          ElevatedButton(
            onPressed:(){
              Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const HomePage()),
      );
          },
          child: Text('Volver'),)
        ],
      ),
    );
  }
}
