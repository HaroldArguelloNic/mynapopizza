
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynapopizza/models/pizza.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

Future<bool> agregarPizza(Pizza pizza) async {
  try {
    await _db.collection('pizzas').add(pizza.toMap());
    return true;
  } catch (e) {
    print('Error al registrar la pizza: $e');
    return false;
  }
}

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> listaPizzas() async {

try {
  List pizzas = [];
  CollectionReference collectionReferenceUsuarios = db.collection('pizzas');
  QuerySnapshot queryUsuarios = await collectionReferenceUsuarios.get();
  queryUsuarios.docs.forEach((documento) {
    pizzas.add(documento.data());
  });
  return pizzas;
} catch (e) {
  // Manejo de errores
  print("Ocurrió un error: $e");
  return []; 
}

}
