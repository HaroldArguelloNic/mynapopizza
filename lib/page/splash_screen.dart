import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mynapopizza/page/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Establece un temporizador para navegar a la página de inicio de sesión después de 2 segundos
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  const LoginPage()),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texto de bienvenida
            
            const Text(
                'PizzaNapo...',
                style: TextStyle(
                  fontStyle: FontStyle.italic, 
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  shadows: [Shadow(
                    color: Colors.black, // Color de la sombra
                    blurRadius: 4, // Radio de desenfoque de la sombra
                    offset: Offset(2, 2), // Desplazamiento de la sombra
                  )],
                ),
              ),
            const SizedBox(
              height: 20.0,
            ),
            // Carga de la imagen de forma asíncrona
            FutureBuilder(
              future: precacheImage(
                const AssetImage('assets/pizza.png'),
                context,
              ),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                // Si la imagen está cargada, muestra la imagen
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                    height: 250.0,
                    width: 350.0,
                    child: Image.asset('assets/pizza.png'),
                  );
                } else {
                  // Mientras la imagen se está cargando, muestra un indicador de progreso
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
