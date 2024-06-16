import 'package:flutter/material.dart';
import 'package:mynapopizza/page/home_page.dart';
import 'package:mynapopizza/page/registration_page.dart';
import 'package:mynapopizza/services/push_notification.dart';
import 'package:mynapopizza/services/login_provider.dart';
import 'package:mynapopizza/validators/validator.dart';

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

  late bool _isObscure = true;
  final bool _isLoading = false;

  static String? token;

   @override
    void initState() {
    super.initState();
    token = PushNotificationService.token;
  }

  @override
  void dispose() {
    super.dispose();
       
    _nameOrEmailController.dispose();
    _contraseniaController.dispose();
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
                        const SizedBox(height: 20,),
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
                              suffixIcon: IconButton(icon: Icon(
                                _isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                              )
                            ),
                            obscureText: _isObscure,
                            validator: Validators.passwordValidator,
                             autovalidateMode: AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        _isLoading? const CircularProgressIndicator(
                                    value: null,
                                    color: Colors.blue,
                                    )
                        // Botón de inicio de sesión
                        : ElevatedButton.icon(
                          onPressed: () {
                            bool valido =_formKey.currentState!.validate();

                            if(valido != false) {
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
}
