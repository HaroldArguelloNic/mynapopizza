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

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
       routes: {
      '/home': (context) => HomePage(),
      '/favoritos': (context) => FavoritosPage(),
      '/producto': (context) => ProductoPage(),
      '/miorden': (context) => CartScreen(),
      '/miperfil': (context) => MyAccountPage(),
    },
    );
  }
}
 