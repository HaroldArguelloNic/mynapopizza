  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynapopizza/models/usuario.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

Future<bool> agregarUsuario(Usuario usuario) async {
  try {
    // Intenta agregar el usuario a la colección de Firestore
    await _db.collection('usuarios').add(usuario.toMap());
    // Si se completa correctamente, devuelve true
    return true;
  } catch (e) {
    // Si ocurre un error, imprime el mensaje de error
    print('Error al agregar usuario: $e');
    // Devuelve false para indicar que no se pudo agregar el usuario
    return false;
  }
}

