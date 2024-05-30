import 'package:flutter/material.dart';
import 'package:mynapopizza/page/registration_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  child: TextField(
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
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  child: TextField(
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
                ElevatedButton.icon(
                  onPressed: () {

                  },
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

        )
        ),
      ),
    );
  }
}
