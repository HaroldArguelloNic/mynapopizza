import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynapopizza/models/articuloscarrito.dart';

class Carrito {
  final String? id; // Identificador único del carrito.
  final String usuarioId; // Identificador del usuario al que pertenece el carrito.
  final List<ArticuloCarrito> articulos; // Lista de artículos en el carrito.
  final double totalPedido; // Total del pedido en el carrito.

  Carrito({
    this.id,
    required this.usuarioId,
    required this.articulos,
    required this.totalPedido,
  });

  Map<String, dynamic> toMap() {
    return {
      'usuarioId': usuarioId,
      'articulos': articulos.map((item) => item.toMap()).toList(),
      'totalPedido': totalPedido,
    };
  }

  Carrito.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        usuarioId = doc.data()!['usuarioId'],
        articulos = (doc.data()!['articulos'] as List<dynamic>)
            .map((item) => ArticuloCarrito.fromMap(item as Map<String, dynamic>))
            .toList(),
        totalPedido = doc.data()!['totalPedido'];
}
