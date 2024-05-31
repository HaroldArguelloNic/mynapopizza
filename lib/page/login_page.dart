import 'package:flutter/material.dart';
import 'package:mynapopizza/page/home_page.dart';

import 'package:mynapopizza/page/registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contraseniaController = TextEditingController();

  //Prueba de login falta implementacion con datos
  void _BetaLogin(BuildContext context) {
    String usuario = _usuarioController.text;
    String contrasena = _contraseniaController.text;

    // Validación simple: Si el usuario es 'admin' y la contraseña es 'admin', consideramos que es válido
    if (usuario == 'admin' && contrasena == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Credenciales inválidas'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200],
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 400,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Icon(
                  Icons.person,
                  size: 110,
                ),
                /*   Texto de bienvenida              */
                const Text(
                  'Bienvenido A MyNapoPizza!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(height: 30),
                // Usuario TextField
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 10.0),
                  child: TextField(
                    controller: _usuarioController,
                    decoration: const InputDecoration(
                      labelText: 'Usuario',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                // Contraseña TextField
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 10.0),
                  child: TextField(
                    controller: _contraseniaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña Aqui',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                // Botón de inicio de sesión
                ElevatedButton.icon(
                  onPressed: () => _BetaLogin(context),
                  icon: const Icon(Icons.door_front_door_rounded),
                  label: const Text(
                    'Login',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: const ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(Size(200, 40)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationPage()),
                    ),
                    child: const Text(
                      '¿Desea Registrarse?',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
