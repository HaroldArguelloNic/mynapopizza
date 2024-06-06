
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