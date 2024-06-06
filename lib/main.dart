import 'package:flutter/material.dart';
import 'package:mynapopizza/page/pizza_form.dart';
import 'package:mynapopizza/page/splash_screen.dart';
import 'package:mynapopizza/page/usuarios_page.dart';
import 'package:mynapopizza/services/push_notification.dart';
import 'page/cart.dart';
import 'page/favoritos.dart';
import 'page/home_page.dart';
import 'page/myaccountpage.dart';
import 'page/producto_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();

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
        '/usuarios' : (context) => const UsuariosPage(),
        '/formPizza':(context) => const PizzaForm(),
      },
    );
  }
}
