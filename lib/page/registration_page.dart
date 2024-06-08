
import 'package:flutter/material.dart';
import 'package:mynapopizza/data/mysql_conection.dart';
import 'package:mynapopizza/models/usuario.dart';
import 'package:mynapopizza/services/usuario_service.dart';

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
  final numeroController = TextEditingController();
  /*
  void insertData() async {
    db.pizzaConnect().then((conn) async {
      String sqlQuery =
          'insert into Clientes (name, email, password ) values(?,?,?)';
      
      await conn.execute(
          sqlQuery,[nameController.text, emailController.text, passwordController.text] as Map<String, dynamic>?);

      setState(() {});
      
    });
  }
  */

void registrarUsuario() async {
  // Verifica que ningún campo esté vacío
  if (nameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor, complete todos los campos')));
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
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Usuario registrado exitosamente')));
     Navigator.pushReplacementNamed(context, '/login');
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al registrar usuario')));
  }
}

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    numeroController.dispose();
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
                    
                    const Text('Nombre de usuario',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
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
                     suffixIcon: const Icon(Icons.person_2, color: Colors.red),
                      ),
                      controller: nameController,
                    ),
                    const Text('Correo Electronico',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
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
                    const Text('Contraseña',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
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
                    const Text('Numero Telefono',style: TextStyle(fontSize: 20,color: Colors.blueAccent), ),
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
                     suffixIcon: const Icon(Icons.phone_in_talk_sharp, color: Colors.red),
                      ),
                      controller: numeroController,
                      
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        child: const Text('Registrarse'),
                        onPressed: () async {
                          /*
                        if(emailController.text != "" && passwordController.text != "" && nameController.text != "" ) {
                          if(PizzaConnect.db == 'success') {
                             const SnackBar(content: Text('conexion exitosa'));
        
                            //insertData();
                          }
                                                    
                        
                        }*/
                         registrarUsuario();
                         
                         
                        },
                      ),
                    ),
                    /*
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        child: const Text('Conectar al servidor'),
                        onPressed: () {


                        }
                        
                      ),
                    ),
                    */
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

// class TextFieldWidget extends StatefulWidget {
//   final String label;
//   final String placeholder;
//   final IconData? icon;
//   final bool isTextArea;
//   final TextEditingController? controller;
  

// // ignore: use_super_parameters
//   const TextFieldWidget(
//       {Key? key,
//       required this.label,
//       required this.placeholder,
//       this.icon,
//       this.isTextArea = false,
//       this.controller
//       })
//       : super(key: key);

//   @override
//   State<TextFieldWidget> createState() => _TextFieldWidgetState();
// }

// class _TextFieldWidgetState extends State<TextFieldWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(widget.label,
//               style: const TextStyle(color: Colors.green, fontSize: 18)),
//           const SizedBox(height: 5.0),
//           Container(
//             padding: const EdgeInsets.only(left: 10.0),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black),
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: TextField(
//               controller: widget.controller,
//               maxLines: widget.isTextArea ? 6 : null,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: widget.placeholder,
//                 suffixIcon: widget.icon != null ? Icon(widget.icon, color: Colors.red) : null,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
