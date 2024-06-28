import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynapopizza/page/home_admin.dart';
import 'package:mynapopizza/page/home_page.dart';
import 'package:mynapopizza/page/registration_page.dart';
import 'package:mynapopizza/services/local_storage.dart';

import 'package:mynapopizza/utils/showsnacbars.dart';
import 'package:mynapopizza/validators/validator.dart';
import 'package:provider/provider.dart';
import '../services/login_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final TextEditingController _nameController = TextEditingController();
  //final TextEditingController _correoElectronicoController = TextEditingController();
  final TextEditingController _nameOrEmailController = TextEditingController();
  final TextEditingController _contraseniaController = TextEditingController();

  late bool _isObscure = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _nameOrEmailController.dispose();
    _contraseniaController.dispose();
  }

  //ingreso con longin
  void onFormLogin(
    String usernameOrEmail,
    String password,
    context,
  ) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final String usernameOrEmailLower = usernameOrEmail.toLowerCase();

      loginProvider.loginUser(
          usernameOrEmail: usernameOrEmailLower,
          password: password,
          onSuccess: () async {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              setState(() {
                _isLoading = false;
              });
              dynamic userData = await loginProvider.getUserData(user.email!);
              //guardar datos de local
              await LocalStorage().saveUserData(
                  _nameOrEmailController.text, _contraseniaController.text);
              //guardar estado de inicio de sesion
              await LocalStorage().setIsSignedIn(true);
              //cambiar estado de autenticacion
              loginProvider.authStatus;
              //navega a la pagina principal
              if (userData['rol'] == 'user') {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return HomePage(userData: userData);
                }));
              } else if (userData['rol'] == 'admin') {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return HomeAdmin(userData: userData);
                }));
              }
            } else {
              setState(() {
                _isLoading = false;
              });
              await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Verifica tu usuario'),
                      content: const Text(
                          'Por favor verifica tu correo electronico para continuar'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Aceptar'))
                      ],
                    );
                  });
            }
          },
          onError: (String error) {
            setState(() {
              _isLoading = false;
            });
            showSnackBar(context, error.toString());
          });
    } else {}
    setState(() {
      _isLoading = false;
    });
  }

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
                          validator: Validators.emailOrUser,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Contraseña TextField
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 10.0),
                          child: TextFormField(
                            controller: _contraseniaController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                labelText: 'Contraseña',
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                suffixIcon: IconButton(
                                  icon: Icon(_isObscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                )),
                            obscureText: _isObscure,
                            validator: Validators.passwordValidator,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _isLoading
                            ? const CircularProgressIndicator(
                                value: null,
                                color: Colors.blue,
                              )
                            // Botón de inicio de sesión
                            : ElevatedButton.icon(
                                onPressed: () {
                                  onFormLogin(_nameOrEmailController.text,
                                      _contraseniaController.text, context);
                                },
                                icon: const Icon(Icons.door_front_door_rounded),
                                label: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: const ButtonStyle(
                                  fixedSize:
                                      WidgetStatePropertyAll(Size(200, 40)),
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
}
