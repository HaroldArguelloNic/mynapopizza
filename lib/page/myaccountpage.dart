import 'package:flutter/material.dart';

class MyAccountPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Mi Cuenta',
          style: TextStyle(fontWeight: FontWeight.w900,
          fontSize: 28,),
        ),
      )
    );
  }
}