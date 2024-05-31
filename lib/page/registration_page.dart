import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mynapopizza/page/sidebar_layout.dart';
import 'package:mynapopizza/data/mysql_conection.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final db = PizzaConnect(); //se asigna la conexion a una variable final
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController(); 
  
  void insertData() async {
    db.pizzaConnect().then((conn) {
      String sqlQuery =
          'insert into Clientes (name, email, password ) values(?,?,?)';
      
      conn.execute(
          sqlQuery,
          [nameController.text, emailController.text, passwordController.text] as Map<String, dynamic>?);
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
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
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: SizedBox(
                width: 450,
                child: Column(
                  children: [
                    const TextFieldWidget(
                      label: 'Nombre de Usuario',
                      placeholder: 'Nombre',
                      icon: Icons.person_2_rounded,
                      //controller: nameController,
                    ),
                    const TextFieldWidget(
                      label: 'correo electronico',
                      placeholder: 'Email',
                      icon: Icons.mail,
                      //controller: emailController,
                    ),
                    const TextFieldWidget(
                      label: 'password',
                      placeholder: 'Contraseña',
                      icon: Icons.lock,
                      //controller: passwordController,
                      
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        child: const Text('Pagina Principal'),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SideBarLayout()),
                        ),
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

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String placeholder;
  final IconData? icon;
  final bool isTextArea;
  final TextEditingController? controller;
  

// ignore: use_super_parameters
  const TextFieldWidget(
      {Key? key,
      required this.label,
      required this.placeholder,
      this.icon,
      this.isTextArea = false,
      this.controller
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.green, fontSize: 18)),
          const SizedBox(height: 5.0),
          Container(
            padding: const EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              controller: controller,
              maxLines: isTextArea ? 6 : null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: placeholder,
                suffixIcon: icon != null ? Icon(icon, color: Colors.red) : null,
              ),
            ),
          )
        ],
      ),
    );
  }
}
