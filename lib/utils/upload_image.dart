import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageUser(BuildContext context) async {
  File? imageUser;
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 50,
    );
  if(pickedFile != null){
    imageUser = File(pickedFile.path);
  }else {}
  return imageUser;
}