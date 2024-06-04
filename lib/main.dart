import 'package:flutter/material.dart';
import 'package:mynapopizza/page/splash_screen.dart';

import 'page/cart.dart';
import 'page/favoritos.dart';
import 'page/home_page.dart';
import 'page/myaccountpage.dart';
import 'page/productoPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomePage(),
        '/favoritos': (context) => const FavoritosPage(),
        '/producto': (context) => const ProductoPage(),
        '/miorden': (context) => const CartScreen(),
        '/miperfil': (context) => const MyAccountPage(),
      },
    );
  }
}
