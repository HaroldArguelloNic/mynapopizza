import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,String content){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.amber,
      content: Text(
        content,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: "MonB",
        ),
      ),)
    );
}