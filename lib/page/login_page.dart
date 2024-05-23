import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              // Icono
              const Icon(
                Icons.person,
                size: 110,
              ),
              const Text(
                'Bienvenido A MyNapoPizza!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
              const SizedBox(height: 40),
              // Usuario TextField
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
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
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
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
              GestureDetector(
                onTap: () {
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Iniciar Sesion",
                      style: TextStyle(
                        color: Color.fromARGB(255, 10, 85, 11),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
