
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';



enum UserRole {admin, user, superAdmin}

class RegisterProvider extends ChangeNotifier{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

// RegisterProvider() {
//   checkSign();
// }

Future<void> registerUser({
  required String name,
  required String correoElectronico,
  required String contrasenia,
  required UserRole rol,
  required Function(String) onError,
  required String token,
  required Function createdAt,
  required File? image,
}) async {
  try {
    //convertir el name a minuscula
    final String usernameLowerCase = name.toLowerCase();

    //verificar si el usuario existe en la base de datos 
    final bool userExist = await checkUserExist(usernameLowerCase);

    if(userExist) {
      onError('El usuario ya existe');
      return;
    }

    //Verificar las credenciales del usuario
    final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: correoElectronico,
      password: contrasenia,
    );

    final User user = userCredential.user!;
    final String userId = user.uid;

    //subir la imagen del usuario al storage

    String imageUrl= '';

    if(image != null) {
      //imageUrl = await uploadImage('usuarios/$userId.jpg', image);
      String direction = 'usuarios/$user/$userId.jpg';
      imageUrl = await uploadImage(direction, image); 
       
    }

  //Guardar los datos del usuario en la base de datos

  final userDatos = {
    'id': userId,
    'name':name,
    'username_lowercase': usernameLowerCase,
    'contrasenia': contrasenia,
    'correoElectronico': correoElectronico,
    'rol': rol,
    'token': token,
    'image': imageUrl,
    'createdAt': createdAt,

  };

  await _firestore.collection('usuarios').doc(userId).set(userDatos);
  } on FirebaseAuthException catch (e){
         if(e.code == 'weak-password') {
        onError('la contraseña es muy debil');
      } else if (e.code == 'email-already-in-use') {
        onError('El email ya esta en uso');
      }

  }
  
   catch (e) {
    onError('Error al registrar el usuario');
  }
}

 

UserRole userRole = UserRole.user;
bool isPasswordVisible= false;
bool isConfirmPasswordVisible = false;

void changeUserRole(UserRole role) {
  userRole = role;
  notifyListeners();
}

void changePasswordVisibility() {
  isPasswordVisible = !isPasswordVisible;
}

//metodo para verificar si el usuario existe en la base de datos
Future<bool> checkUserExist(String username) async {
  final QuerySnapshot result = await _firestore
  .collection('usuarios')
  .where('name', isEqualTo: username)
  .limit(1)
  .get();

  return result.docs.isNotEmpty;
}

//metodo para guardar la imagen en el storage y obtener la url
 Future<String> uploadImage(String ref, File file) async {
   final UploadTask uploadTask = _storage.ref().child(ref).putFile(file);
   final TaskSnapshot taskSnapshot = await uploadTask;
   final String url= await taskSnapshot.ref.getDownloadURL();
   return url;
 }

  Future<bool> checkEmailExist(String email) async{ 
  final QuerySnapshot result = await _firestore
  .collection('usuarios')
  .where('correoElectronico', isEqualTo: email)
  .limit(1)
  .get();

  return result.docs.isNotEmpty;
  }
}