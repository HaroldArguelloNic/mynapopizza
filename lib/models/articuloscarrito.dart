
class ArticuloCarrito {
  final String pizzaId; // ID de la pizza.
   int cantidad; // Cantidad de pizzas en el carrito.
  final double precio; // Precio de la pizza en el momento en que se agrega al carrito.
  final String nombre;

  ArticuloCarrito({
    required this.pizzaId,
    required this.cantidad,
    required this.precio,
    required this.nombre
  });

  Map<String, dynamic> toMap() {
    return {
      'pizzaId': pizzaId, // Guarda el ID de la pizza.
      'cantidad': cantidad,
      'precio': precio, // Guarda el precio de la pizza en el momento de la compra.
    };
  }

  ArticuloCarrito.fromMap(Map<String, dynamic> map)
      : pizzaId = map["pizzaId"],
        cantidad = map["cantidad"],
        precio = map["precio"],
        nombre= map["nombre"];
}
