import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynapopizza/data/mysql_conection.dart';
import 'package:mynapopizza/services/push_notification.dart';
import 'package:mynapopizza/services/register_provider.dart';
import 'package:mynapopizza/utils/showsnacbars.dart';
import 'package:provider/provider.dart';
import '../utils/upload_image.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

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
  File? imageUser;
  static String? token;

  @override
  void initState() {
    super.initState();
    token = PushNotificationService.token;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    numeroController.dispose();
  }

  //Registrar Usuario
  void submitRegister() async {
    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      //Verificar si el usuario existe
      final bool existUserName =
          await registerProvider.checkUserExist(nameController.text);
      if (existUserName) {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, "El nombre de usuario ya existe");
        return;
      }
      final bool existEmail =
          await registerProvider.checkEmailExist(emailController.text);
      if (existEmail) {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, "correo de usuario ya existe");
        return;
      }
      //validar que ingrese imagen de perfil
      if (imageUser == null) {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(context, "Ingrese la imagen de perfil");
        return;
      }

      //obtenener fecha y hora actual
      final now = DateTime.now().toString();

      //Registrar usuario
      try {
        await registerProvider.registerUser(
          name: nameController.text,
          correoElectronico: emailController.text.toLowerCase().trim(),
          contrasenia: passwordController.text.trim(),
          rol: UserRole.user,
          token: token!,
          createdAt: now,
          imageUser: imageUser,
          onError: (error) {
            showSnackBar(context, error);
          },
        );
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        showSnackBar(context, 'Revise su cuenta de correo');
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
        setState(() {
          _isLoading = false;
        });
      } on FirebaseAuthException catch (e) {
        showSnackBar(context, e.toString());
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        showSnackBar(context, e.toString());
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  //Seleccionar una imagen
  void selectedImage() async {
    imageUser = await pickImageUser(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
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
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.greenAccent,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          selectedImage();
                        },
                        child: imageUser == null
                            ? const CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.amberAccent,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 40,
                                  color: Colors.greenAccent,
                                ),
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(imageUser!),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Nombre de usuario',
                        style:
                            TextStyle(fontSize: 20, color: Colors.blueAccent),
                      ),
                      TextFormField(
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese su nombre';
                          }
                          return null;
                        },
                      ),
                      const Text(
                        'Correo Electronico',
                        style:
                            TextStyle(fontSize: 20, color: Colors.blueAccent),
                      ),
                      TextFormField(
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese su correo electrónico';
                          }
                          return null;
                        },
                      ),
                      const Text(
                        'Contraseña',
                        style:
                            TextStyle(fontSize: 20, color: Colors.blueAccent),
                      ),
                      TextFormField(
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese su contraseña';
                          }
                          return null;
                        },
                      ),
                      const Text(
                        'Numero Telefono',
                        style:
                            TextStyle(fontSize: 20, color: Colors.blueAccent),
                      ),
                      TextFormField(
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese su número de teléfono';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            filled: true,
                            fillColor: Colors.amberAccent,
                            focusColor: Colors.cyanAccent,
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
                              },
                            )),
                        controller: registerDay,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese la fecha de registro';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                value: BorderSide.strokeAlignCenter,
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  submitRegister();
                                },
                                child: const Text('Registrarse'),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
