import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthStatus { notAuthenticated, checking, authenticated }

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthStatus authStatus = AuthStatus.notAuthenticated;

  Future<void> loginUser({
    required String usernameOrEmail,
    required String password,
    required Function onSuccess,
    required Function(String) onError,
  }) async {
    try {
      authStatus = AuthStatus.checking;
      notifyListeners();

      final String usernameOrEmailLowerCase = usernameOrEmail.toLowerCase();

      // Buscar por nombre de usuario
      QuerySnapshot result = await _firestore
          .collection('usuarios')
          .where('nombre', isEqualTo: usernameOrEmailLowerCase)
          .limit(1)
          .get();

      if (result.docs.isNotEmpty) {
        final String email = result.docs.first.get('correoElectronico');
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        onSuccess();
        return;
      }

      // Si no se encuentra por nombre de usuario, buscar por correo electrónico
      result = await _firestore
          .collection('usuarios')
          .where('correoElectronico', isEqualTo: usernameOrEmailLowerCase)
          .limit(1)
          .get();

      if (result.docs.isNotEmpty) {
        final String email = result.docs.first.get('correoElectronico');
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        onSuccess();
        return;
      }

      onError('No se encontró un usuario o email ingresado');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        onError('Usuario o contraseña incorrecto');
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
    }
  }

  // Método para obtener el usuario actualmente autenticado
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
