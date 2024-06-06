import 'package:flutter/material.dart';

import 'package:mynapopizza/page/home_page.dart';
//import 'package:mynapopizza/page/home_page.dart';
import 'package:mynapopizza/page/registration_page.dart';
import 'package:mynapopizza/services/push_notification.dart';
//import 'package:mynapopizza/services/login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _correoElectronicoController = TextEditingController();
  final TextEditingController _nameOrEmailController = TextEditingController();
  final TextEditingController _contraseniaController = TextEditingController();

  final bool _isObscure = true;
  

  static String? token;

  @override
  void initState() {
    super.initState();
    token = PushNotificationService.token;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _correoElectronicoController.dispose();
    _nameOrEmailController.dispose();
    _contraseniaController.dispose();
  }

  //Prueba de login falta implementacion con datos
  // ignore: non_constant_identifier_names
  // void _BetaLogin(BuildContext context) {
  //   String usuario = _usuarioController.text;
  //   String contrasena = _contraseniaController.text;

  // Validación simple: Si el usuario es 'admin' y la contraseña es 'admin', consideramos que es válido
  //   if (usuario == 'admin' && contrasena == 'admin') {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const HomePage()),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Credenciales inválidas'),
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200],
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 400,
            child: Form(
              key: _formKey,
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
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameOrEmailController,
                          decoration: const InputDecoration(
                            labelText: 'Ingresa usuario o contraseña',
                            hintText: "user@example.com",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        // Contraseña TextField
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 10.0),
                          child: TextFormField(
                            controller: _contraseniaController,
                            obscureText: _isObscure,
                            decoration: const InputDecoration(
                              labelText: 'Contraseña',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            validator: (password) => password!.isNotEmpty
                             ? "Ingresa la contraseña": null,
                             autovalidateMode: AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        
                        // Botón de inicio de sesión
                        ElevatedButton.icon(
                          onPressed: () {
                            
                            bool valido =_formKey.currentState!.validate();

                            if(valido != true) {
                              Navigator.push(context,                                                          
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HomePage())
                              );
                            }


                              
                             
                              

                            
                                                        
                          },
                          icon: const Icon(Icons.door_front_door_rounded),
                          label: const Text(
                            'Login',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: const ButtonStyle(
                            fixedSize: WidgetStatePropertyAll(Size(200, 40)),
                          ),
                        ),
                        Row(
                          children:[ 
                            const Text('¿No tienes cuenta?'),
                            TextButton(
                            onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegistrationPage()),
                            ),
                            child: const Text(
                              'Registrate?',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Por favor ingrese un correo valido';
    }
    return null;
  }
}
