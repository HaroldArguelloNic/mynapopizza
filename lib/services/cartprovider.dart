import 'package:flutter/material.dart';

class CartItem {
  final String pizzaId; 
  final double precio; 
  final String nombre; 
  int cantidad; 
  
  CartItem({
    required this.pizzaId,
    required this.precio,
    required this.nombre,
    this.cantidad = 1, // Inicializar cantidad en 1 por defecto
  });
}

// Clase del proveedor del carrito
class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];

  // Getter para obtener la lista de elementos del carrito
  List<CartItem> get items => [..._items];

  // Método para agregar un artículo al carrito
  void addToCart(String nombre, String pizzaId, double precio) {
    var index = _items.indexWhere((item) => item.pizzaId == pizzaId);
    if (index != -1) {
      // Si el artículo ya está en el carrito, incrementa la cantidad
      _items[index].cantidad++;
    } else {
      // Si el artículo no está en el carrito, agrégalo
      _items.add(CartItem(
        nombre: nombre,
        pizzaId: pizzaId,
        precio: precio,
        
      ));
    }
    notifyListeners(); // Notifica a los listeners que el estado ha cambiado
  }

  // Método para eliminar un artículo del carrito
  void removeFromCart(String pizzaId) {
    _items.removeWhere((item) => item.pizzaId == pizzaId);
    notifyListeners(); 
  }

  // Método para incrementar la cantidad de un artículo
  void incrementQuantity(String pizzaId) {
    var index = _items.indexWhere((item) => item.pizzaId == pizzaId);
    if (index != -1) {
      _items[index].cantidad++;
      notifyListeners(); 
    }
  }

  // Método para decrementar la cantidad de un artículo
  void decrementQuantity(String pizzaId) {
    var index = _items.indexWhere((item) => item.pizzaId == pizzaId);
    if (index != -1 && _items[index].cantidad > 1) {
      _items[index].cantidad--;
      notifyListeners(); 
    }
  }

  // Método para obtener el precio total del carrito
  double getTotalPrice() {
    double totalPrice = 0.0;
    _items.forEach((item) {
      totalPrice += item.precio * item.cantidad; // Multiplicar por la cantidad
    });
    return totalPrice;
  }

  // Método para verificar si un artículo ya está en el carrito
  bool isInCart(String pizzaId) {
    return _items.any((item) => item.pizzaId == pizzaId);
  }

  // Método para limpiar el carrito (eliminar todos los elementos)
  void clearCart() {
    _items.clear();
    notifyListeners(); 
  }
}
