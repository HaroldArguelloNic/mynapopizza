
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

Future<List<DocumentSnapshot>> listaPizzas() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('pizza').get();
    
    List<DocumentSnapshot> pizzas = querySnapshot.docs;
    pizzas.forEach((pizza) {
      print('\n');
      print("Nombre: ${pizza['name']}, Imagen URL: ${pizza['imageUrl']}");
    });

    if(pizzas == null){
      print('No hay datos');
    }
    
    return pizzas; // Retorna la lista de documentos (pizzas)
  } catch (error) {
    print("Error al obtener la lista de pizzas: $error");
    return []; // Retorna una lista vacía en caso de error
  }
}
