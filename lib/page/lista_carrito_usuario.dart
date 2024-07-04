import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mynapopizza/models/carrito.dart';
import 'package:mynapopizza/services/cartservices.dart';
import 'package:mynapopizza/services/login_provider.dart';
import 'package:provider/provider.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({Key? key}) : super(key: key);

  @override
  _PedidosPageState createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  User? user;
  final CarritoService _carritoService = CarritoService();
  List<Carrito>? _pedidos;

  @override
  void initState() {
    super.initState();
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    user = loginProvider.getCurrentUser();
    _fetchPedidos();
  }

  void _fetchPedidos() async {
    if (user != null) {
      var pedidos = await _carritoService.obtenerPedidos(user!.uid);
      setState(() {
        _pedidos = pedidos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Pedidos'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.blue.shade200],
            stops: const [0.3, 0.9],
          ),
        ),
        child: _pedidos == null
            ? const Center(child: CircularProgressIndicator())
            : _pedidos!.isEmpty
                ? const Center(child: Text('No hay pedidos disponibles'))
                : ListView.builder(
                    itemCount: _pedidos!.length,
                    itemBuilder: (context, index) {
                      var pedido = _pedidos![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Card(
                          elevation: 6.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            title: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade400,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                'Pedido ID: ${pedido.id ?? 'N/A'}',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            children: [
                              ListTile(
                                title: Text(DateFormat.yMMMd()
                                    .format(pedido.fechaPedido)),
                                subtitle: const Text('Fecha del pedido'),
                                textColor: Colors.black,
                              ),
                              const Divider(),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: pedido.articulos.length,
                                itemBuilder: (context, itemIndex) {
                                  var articulo = pedido.articulos[itemIndex];
                                  return ListTile(
                                    title: Text(articulo.nombre),
                                    subtitle: Text(
                                      '${articulo.cantidad} x \$${articulo.precio.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                title: const Text(
                                  'Total del pedido:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: Text(
                                  '\$${pedido.totalPedido.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
