
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynapopizza/models/pizza.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

Future<bool> agregarUsuario(Pizza pizza) async {
  try {
    // Intenta agregar el usuario a la colección de Firestore
    await _db.collection('pizzas').add(pizza.toMap());
    // Si se completa correctamente, devuelve true
    return true;
  } catch (e) {
    // Si ocurre un error, imprime el mensaje de error
    print('Error al agregar usuario: $e');
    // Devuelve false para indicar que no se pudo agregar el usuario
    return false;
  }
}