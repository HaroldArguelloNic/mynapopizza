import 'package:flutter/material.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: const Text('Mi Cuenta',
          style: TextStyle(fontWeight: FontWeight.w900,
          fontSize: 28,),
        ),
      )
    );
  }
}