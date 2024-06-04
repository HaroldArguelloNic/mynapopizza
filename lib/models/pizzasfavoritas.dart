import 'package:cloud_firestore/cloud_firestore.dart';
class PizzasFavoritas {
  final String? id;
  final String usuarioId;
  final List<String> pizzaIds;

  PizzasFavoritas({
    this.id,
    required this.usuarioId,
    required this.pizzaIds,
  });

  // Convierte el objto o clase pizzasFavoritas a un map.
  Map<String, dynamic> toMap() {
    return {
      'usuarioId': usuarioId,
      'pizzaIds': pizzaIds,
    };
  }

  // Crea una instancia de pizzasFavoritas a partir de un documento de Firestore
  PizzasFavoritas.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        usuarioId = doc.data()!["usuarioId"],
        pizzaIds = List<String>.from(doc.data()!["pizzaIds"]);
}
