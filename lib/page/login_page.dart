import 'package:flutter/material.dart';
import 'package:mynapopizza/page/home_page.dart';

import 'package:mynapopizza/page/registration_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State <LoginPage>{

  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contraseniaController = TextEditingController();

  void _BetaLogin() {
    //Prueba de login falta implementacion con datos.
    String usuario = _usuarioController.text;
    String contrasena = _contraseniaController.text;

    // Validación simple: Si el usuario es 'admin' y la contraseña es 'admin', consideramos que es válido
    if (usuario == 'admin' && contrasena == 'admin') {
      // Si las credenciales son válidas, navegamos a la próxima vista
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Cambia HomePage por el nombre de tu próxima vista
      );
    } else {
      // Si las credenciales son inválidas, mostramos un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Credenciales inválidas'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200], // change Color
      body: SingleChildScrollView(
        child: Center(
            // change SafeArea
            child: SizedBox(
          // add SizedBox
          width: 400, // ancho 600
          child: Center(
            // icono de persona
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                // Icono
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  child: TextField(
                    controller: _usuarioController,
                    decoration: InputDecoration(
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  child: TextField(
                    controller: _contraseniaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                // Botón de inicio de sesión
                GestureDetector(
                  onTap:  _BetaLogin,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        "Iniciar Sesión",
                        style: TextStyle(
                          color: Color.fromARGB(255, 10, 85, 11),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrationPage()),
                  ),
                  child: const Text(
                    'Registrar usuario',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                ElevatedButton.icon(
                  onPressed: null,
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
                      'Registrar usuario',
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

        )
        ),
      ),
    );
  }
}

