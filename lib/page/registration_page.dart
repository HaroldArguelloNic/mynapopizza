import 'package:flutter/material.dart';
import 'package:mynapopizza/data/mysql_conection.dart';
import 'package:mynapopizza/models/usuario.dart';
import 'package:mynapopizza/services/usuario_service.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final db = PizzaConnect(); //se asigna la conexion a una variable final

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final numeroController = TextEditingController();
  final registerDay = TextEditingController();

  bool _isObscure = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    numeroController.dispose();
  }

  void registrarUsuario() async {
    // Verifica que ningún campo esté vacío
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Por favor, complete todos los campos')));
      return;
    }

    // Crea el objeto Usuario con los datos de los controladores
    Usuario usuario = Usuario(
      nombre: nameController.text,
      correoElectronico: emailController.text,
      contrasenia: passwordController.text,
      numeroTelefono: numeroController.text,
    );

    // Intenta registrar el usuario y espera la respuesta
    bool registroExitoso = await agregarUsuario(usuario);

    // Verifica si el registro fue exitoso
    if (registroExitoso) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario registrado exitosamente')));
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al registrar usuario')));
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/background2.jpg',
          ),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Registro de Usuario'),
            centerTitle: true,
            backgroundColor: Colors.amber,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(context,
                    '/login'); // Esto navegará de vuelta a la página anterior
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: 600,
              width: 500,
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.bottomCenter,
              color: Colors.white,
              child: SizedBox(
                height: 500,
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Nombre de usuario',
                      style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: Colors.amberAccent,
                        focusColor: Colors.cyanAccent,
                        hintText: 'Digite su Nombre',
                        suffixIcon:
                            const Icon(Icons.person_2, color: Colors.red),
                      ),
                      controller: nameController,
                    ),
                    const Text(
                      'Correo Electronico',
                      style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: Colors.amberAccent,
                        focusColor: Colors.cyanAccent,
                        hintText: 'Digite su Email',
                        suffixIcon: const Icon(Icons.mail, color: Colors.red),
                      ),
                      controller: emailController,
                    ),
                    const Text(
                      'Contraseña',
                      style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: Colors.amberAccent,
                        focusColor: Colors.cyanAccent,
                        hintText: 'Digite un Password',
                        suffixIcon: const Icon(Icons.lock, color: Colors.red),
                      ),
                      controller: passwordController,
                    ),
                    const Text(
                      'Numero Telefono',
                      style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: Colors.amberAccent,
                        focusColor: Colors.cyanAccent,
                        hintText: 'Digite su Numero de Telefono',
                        suffixIcon: const Icon(Icons.phone_in_talk_sharp,
                            color: Colors.red),
                      ),
                      controller: numeroController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "dd/mm/yyy",
                          labelText: 'Ingrese la fecha de registro',
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today_outlined),
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                ).then((DateTime? value) {
                                  if (value != null) {
                                    registerDay.text = value.toString();
                                  }
                                });
                              })),
                      controller: registerDay,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        child: const Text('Registrarse'),
                        onPressed: () async {
                          registrarUsuario();
                        },
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