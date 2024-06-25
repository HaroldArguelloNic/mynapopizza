import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynapopizza/firebase_options.dart';
import 'package:mynapopizza/services/cartprovider.dart';
import 'package:mynapopizza/services/local_storage.dart';
import 'package:mynapopizza/services/register_provider.dart';
import 'package:provider/provider.dart'; // Importa el paquete provider
import 'package:mynapopizza/page/login_page.dart';
import 'package:mynapopizza/page/pizza_form.dart';
import 'package:mynapopizza/page/registration_page.dart';
import 'package:mynapopizza/page/splash_screen.dart';
import 'package:mynapopizza/page/usuarios_page.dart';
import 'package:mynapopizza/services/push_notification.dart';
import 'page/cartpage.dart';
import 'page/favoritos.dart';
import 'page/home_page.dart';
import 'page/myaccountpage.dart';
import 'page/producto_page.dart';
import 'services/login_provider.dart'; // Asegúrate de importar tu LoginProvider aquí

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage().init();
  final isLogged = LocalStorage().getIsLoggedIn();
  await PushNotificationService.initializeApp();
  await Firebase.initializeApp(
    options:
      DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => LoginProvider()), // Añade tu LoginProvider aquí
        ChangeNotifierProvider(lazy: false , create: (_) => RegisterProvider()),// tu LoginProvider aquí
         ChangeNotifierProvider(create: (_) => CartProvider()), //Carrito Provider
        // Puedes agregar otros providers si es necesario
      ],
      child: MyApp( isLogged:isLogged ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLogged;
  const MyApp({super.key, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Cambia la pantalla de inicio según tus necesidades
      routes: {
        '/home': (context) => const HomePage(userData: null,),
        '/favoritos': (context) => const FavoritosPage(),
        '/producto': (context) => const ProductoPage(),
        '/miorden': (context) => const CartScreen(),
        '/miperfil': (context) => const MyAccountPage(),
        '/usuarios': (context) => const UsuariosPage(),
        '/formPizza': (context) => const PizzaForm(),
        '/registrousuario': (context) => const RegistrationPage(),
        '/login': (context) => const  LoginPage(),
      },
    );
  }
}
