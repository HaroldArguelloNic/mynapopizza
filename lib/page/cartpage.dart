import 'package:flutter/material.dart';
import 'package:mynapopizza/models/articuloscarrito.dart';
import 'package:mynapopizza/services/cartprovider.dart';
import 'package:mynapopizza/services/cartservices.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user; // Usuario actual

  @override
  void initState() {
    super.initState();
    // Obtener el usuario actual utilizando FirebaseAuth
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final carritoService =
        CarritoService(); // Instancia del servicio CarritoService

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Column(
            children: [
              cartProvider.items.isEmpty
                  ? const Expanded(
                      child: Center(child: Text('El carrito está vacío')),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Nombre')),
                            DataColumn(label: Text('Precio')),
                            DataColumn(label: Text('Cantidad')),
                            DataColumn(label: Text('Subtotal')),
                            DataColumn(label: Text('Acciones')),
                          ],
                          rows: cartProvider.items.map((item) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    item.nombre,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ), // Mostrar nombre de la pizza
                                DataCell(Text(
                                    '\$${item.precio.toStringAsFixed(2)}')),
                                DataCell(
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          cartProvider
                                              .decrementQuantity(item.pizzaId);
                                        },
                                      ),
                                      Text(item.cantidad.toString()),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          cartProvider
                                              .incrementQuantity(item.pizzaId);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                DataCell(Text(
                                    '\$${(item.precio * item.cantidad).toStringAsFixed(2)}')),
                                DataCell(
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      cartProvider.removeFromCart(item.pizzaId);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '${item.nombre} eliminado del carrito'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Usuario no autenticado'),
                            ),
                          );
                          return;
                        }

                        // Obtener los artículos del carrito actual
                        List<ArticuloCarrito> articulos =
                            cartProvider.items.map((item) {
                          return ArticuloCarrito(
                            pizzaId: item.pizzaId,
                            precio: item.precio,
                            cantidad: item.cantidad,
                            nombre: item.nombre,
                          );
                        }).toList();

                        // Guardar el carrito en Firestore con el uid del usuario
                        await carritoService.guardarCarrito(
                            user!.uid, articulos, DateTime.now());

                        // Limpiar el carrito local después de guardar en Firestore
                        cartProvider.clearCart();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Pedido confirmado y carrito guardado en Firebase'),
                          ),
                        );
                      },
                      child: const Text('Confirmar Pedido'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para cancelar el pedido
                        cartProvider.clearCart();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Cancelar Pedido'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total Pedido: ${cartProvider.items.isNotEmpty ? '\$${cartProvider.getTotalPrice().toStringAsFixed(2)}' : '0.00'}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
