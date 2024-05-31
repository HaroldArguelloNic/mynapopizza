import 'package:flutter/material.dart';
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    // llenar esta lista con datos esto es beta.
    final List<Map<String, dynamic>> cartItems = [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('El carrito está vacío'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(cartItems[index]['name']),
                  subtitle: Text('\$${cartItems[index]['price']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      setState(() {
                        cartItems.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            '${cartItems[index]['name']} eliminada del carrito'),
                      ));
                    },
                  ),
                );
              },
            ),
    );
  }
}