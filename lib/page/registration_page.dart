import 'package:flutter/material.dart';



class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) =>
     Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background2.jpg',),
          fit: BoxFit.cover,)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Registro de Usuario'),
          centerTitle: true,
          backgroundColor: Colors.amber,
        ),
        body:
          const Padding(
          padding: EdgeInsets.all(12.0),
          child: Center(
                child: SizedBox(
                  width:  450,
                  child: Column(
          
                    children: [
                      TextFieldWidget(
                        label: 'Nombre de Usuario',
                        placeholder: 'Nombre',
                        icon: Icons.person_2_rounded,       
                      ),
                      TextFieldWidget(
                        label: 'correo electronico',
                        placeholder: 'Email',
                        icon: Icons.mail,       
                      ),
                    ],  
                  ),
                  
                ),
            ),
          ),
        ),
    );
             

      
  }



class TextFieldWidget extends StatelessWidget{ 

final String label;
final String placeholder;
final IconData? icon;
final bool isTextArea;
final TextEditingController? controller;

// ignore: use_super_parameters
const TextFieldWidget({
Key? key,
required this.label,
required this.placeholder,
this.icon,
this.isTextArea= false , this.controller
  }) : super(key : key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(label, style:const TextStyle( color: Colors.green, fontSize: 18)  ),
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
                suffixIcon: icon != null ? Icon(icon, color: Colors.red): null,
      
              ),
            ),
          )
        ],
      ),
    );
  }
}