
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

    for (var documento in queryPizzas.docs) {
      Map<String, dynamic> pizzaData = documento.data() as Map<String, dynamic>;
      pizzaData['id'] = documento.id; // Agregar el campo 'id' al mapa de datos de la pizza
      pizzas.add(pizzaData);
      print(documento.id); // Imprimir el ID del documento (opcional)
    }

    return pizzas;
  } catch (e) {
    print("Ocurrió un error al obtener las pizzas: $e");
    return [];
  }
}

