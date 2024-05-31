import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Lista de elementos en el carrito (nombre y precio)
  final List<Map<String, dynamic>> cartItems = [];

  // Función para calcular el total del pedido
  double getTotalPrice() {
    double totalPrice = 0.0;
    for (var item in cartItems) {
      totalPrice += item['price'];
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: Column(
        children: [
          // Diseño para mostrar la lista de elementos en el carrito
          cartItems.isEmpty
              ? Center(child: Text('El carrito está vacío'))
              : Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        title: Text(cartItems[index]['name']),
                        subtitle: Text('\$${cartItems[index]['price']}'),
                        // Diseño del botón para eliminar un elemento del carrito
                        trailing: IconButton(
                          icon: Icon(Icons.remove_shopping_cart),
                          onPressed: () {
                            setState(() {
                              cartItems.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${cartItems[index]['name']} eliminada del carrito'),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
          // Diseño del texto que muestra el total del pedido
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total Pedido: ${cartItems.isNotEmpty ? '\$${getTotalPrice()}' : '0'}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}


