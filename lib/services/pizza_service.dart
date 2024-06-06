
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

Future<List<Map<String, dynamic>>> listaPizzas() async {
  try {
    List<Map<String, dynamic>> pizzas = [];
    CollectionReference collectionReferencePizzas = _db.collection('pizzas');
    QuerySnapshot queryPizzas = await collectionReferencePizzas.get();
    queryPizzas.docs.forEach((documento) {
      pizzas.add(documento.data() as Map<String, dynamic>);
    });
    return pizzas;
  } catch (e) {
    // Manejo de errores
    print("Ocurrió un error: $e");
    return [];
  }
}
