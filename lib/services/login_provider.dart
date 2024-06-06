
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthStatus {notAutentication, checking, authenticated}

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthStatus authStatus = AuthStatus.notAutentication;

  Future<void> loginUser({
    required String usernameOrEmail,
    required String password,
    required Function onSuccess,
    required Function(String) onError,
  }) async {
    try {
      
      authStatus = AuthStatus.checking;
      notifyListeners();
      //Ingreso con nombre de usuario
      final String usernameOrEmailLowerCase = usernameOrEmail.toLowerCase();
      final QuerySnapshot result = await _firestore
        .collection('usuarios')
        .where('nombre', isEqualTo:usernameOrEmailLowerCase)
        .limit(1)
        .get();

        if(result.docs.isNotEmpty) {
          final String email = result.docs.first.get('correoElectronico');
          final UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email,
             password: password);
          onSuccess();
          return ;         
        }
      // para ingresar con email
      final QuerySnapshot resultEmail = await _firestore
        .collection('usuarios')
        .where('correoElectronico', isEqualTo:usernameOrEmailLowerCase)
        .limit(1)
        .get();

        if(resultEmail.docs.isNotEmpty){
          final String email = result.docs.first.get('correoElectronico');
          final UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email,
             password: password);
          onSuccess();
          return ;         

        }
      onError('No se encontro un usuario o email ingresado');

    }
    on FirebaseAuthException catch(e) {
      if(e.code == 'user-not-found' || e.code == 'wrong-password') {
        onError('Usuario o contraseña incorrecto');
      }
    }
     catch (e) {
      onError(e.toString()) ;
    }
  }
// verificar si nombre de usuario existe


}