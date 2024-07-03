import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynapopizza/models/articuloscarrito.dart';
import 'package:mynapopizza/models/carrito.dart';

class CarritoService {
  final CollectionReference _carritosCollection =
      FirebaseFirestore.instance.collection('carritos');

  // Método para guardar el carrito en Firestore
  Future<void> guardarCarrito(String usuarioId, List<ArticuloCarrito> articulos,
      DateTime fechaPedido) async {
    // Generar un nuevo ID para el carrito
    String carritoId = _carritosCollection.doc().id;

    // Calcular el total del pedido
    double totalPedido = 0.0;
    articulos.forEach((articulo) {
      totalPedido += articulo.cantidad * articulo.precio;
    });

    var carritoDocRef = _carritosCollection.doc(carritoId);

    var carritoData = {
      'usuarioId': usuarioId,
      'articulos': articulos.map((articulo) => articulo.toMap()).toList(),
      'totalPedido': totalPedido,
      'fechaPedido': fechaPedido,
    };

    await carritoDocRef.set(carritoData);
  }

  // Método para agregar un artículo al carrito existente en Firestore
  Future<void> agregarArticuloAlCarrito(String usuarioId,
      ArticuloCarrito nuevoArticulo, DateTime fechaPedido) async {
    var carrito = await obtenerCarrito(usuarioId);

    if (carrito != null) {
      var existingIndex = carrito.articulos
          .indexWhere((articulo) => articulo.pizzaId == nuevoArticulo.pizzaId);
      if (existingIndex != -1) {
        carrito.articulos[existingIndex].cantidad += nuevoArticulo.cantidad;
      } else {
        carrito.articulos.add(nuevoArticulo);
      }
      await guardarCarrito(usuarioId, carrito.articulos, fechaPedido);
    } else {
      var nuevoCarrito = Carrito(
          usuarioId: usuarioId,
          articulos: [nuevoArticulo],
          totalPedido: 0.0,
          fechaPedido: fechaPedido);
      await guardarCarrito(usuarioId, nuevoCarrito.articulos, fechaPedido);
    }
  }

  // Método para obtener el carrito del usuario desde Firestore
  Future<Carrito?> obtenerCarrito(String usuarioId) async {
    var querySnapshot = await _carritosCollection
        .where('usuarioId', isEqualTo: usuarioId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var carritoDocSnapshot = querySnapshot.docs.first;
      return Carrito.fromDocumentSnapshot(carritoDocSnapshot
          as QueryDocumentSnapshot<
              Map<String,
                  dynamic>>); // Corrección para asegurar el tipo correcto de QueryDocumentSnapshot
    }

    return null;
  }

Future<List<Carrito>> obtenerPedidos(String usuarioId) async {
  var query = _carritosCollection.where('usuarioId', isEqualTo: usuarioId);

  var querySnapshot = await query.get();

  return querySnapshot.docs
      .map((doc) => _carritoFromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>)) // Asegúrate de castear a DocumentSnapshot<Map<String, dynamic>>
      .toList();
}

Carrito _carritoFromSnapshot(DocumentSnapshot<Map<String, dynamic>> carritoDocSnapshot) {
  var data = carritoDocSnapshot.data()!;
  return Carrito(
    id: carritoDocSnapshot.id,
    usuarioId: data['usuarioId'],
    articulos: (data['articulos'] as List<dynamic>)
        .map((item) => ArticuloCarrito.fromMap(item))
        .toList(),
    totalPedido: data['totalPedido'],
    fechaPedido: (data['fechaPedido'] as Timestamp).toDate(),
  );
}

}
