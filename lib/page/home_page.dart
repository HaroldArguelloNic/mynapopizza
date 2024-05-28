import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: const Text('Home Page',
          style: TextStyle(fontWeight: FontWeight.w900,
          fontSize: 28,),
        ),
      )
    );
  }
}