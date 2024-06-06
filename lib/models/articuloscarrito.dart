import 'package:mynapopizza/models/pizza.dart';

class ArticuloCarrito {
  final Pizza pizza; // Objeto Pizza asociado al artículo del carrito.
  final int cantidad; // Cantidad de pizzas en el carrito.

  ArticuloCarrito({
    required this.pizza,
    required this.cantidad,
  });

  Map<String, dynamic> toMap() {
    return {
      'pizza': pizza.toMap(), // Convertimos la pizza a un map para guardarlo en Firestore.
      'cantidad': cantidad,
    };
  }

  ArticuloCarrito.fromMap(Map<String, dynamic> map)
      : pizza = Pizza( // Usamos el constructor de Pizza para crear un objeto Pizza
            id: map["pizza"]["id"],
            nombre: map["pizza"]["nombre"],
            precio: map["pizza"]["precio"],
            rebanadas: map["pizza"]["rebanadas"],
            tamanio: map["pizza"]["tamaño"],
            descripcion: map["pizza"]["descripcion"],
            imageUrl: map["pizza"]["imagenUrl"],
          ),
        cantidad = map["cantidad"];
}