import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mynapopizza/page/pizza_form.dart';
import 'package:mynapopizza/services/pizza_service.dart'; // Importa la función listaPizzas desde el servicio de pizza

class ProductoPage extends StatefulWidget {
  const ProductoPage({super.key});

  @override
  ProductoPageState createState() => ProductoPageState();
}

class ProductoPageState extends State<ProductoPage> {
  late Future<List<Map<String, dynamic>>> _futurePizzas;

  @override
  void initState() {
    super.initState();
    _futurePizzas =
        listaPizzas(); // Obtiene la lista de pizzas al iniciar la página
  }

  void _registerPizza(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: PizzaForm(),
        );
      },
    );
  }

  final pizzaCollection = FirebaseFirestore.instance.collection('pizzas');
  Future<void> editfield(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Edit $field',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: 'Entre el nuevo $field',
              hintStyle: const TextStyle(color: Colors.grey)),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // cancel button
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              )),
          //save button
          TextButton(
              onPressed: () => Navigator.of(context).pop(newValue),
              child: const Text(
                'Guardar',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
    //update in FIrestore
    if (newValue.trim().length > 0) {
      await pizzaCollection.doc().update({field: newValue});
    }
  }

  Widget _buildPizzaCard(
      String nombre, String imageUrl, String descripcion, String precio) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imagenPizza(imageUrl),
          const SizedBox(width: 10), // Espacio entre la imagen y el contenido
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  nombre,
                  textAlign: TextAlign.center, // Centra el texto
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    height: 5), // Espacio entre el nombre y el precio
                Text(
                  'Precio: \$$precio',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold), // Estilo del precio
                ),
                const SizedBox(
                    height: 5), // Espacio entre el precio y la descripción
                Text(
                  'Descripción: $descripcion',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                    height: 10), // Espacio entre la descripción y el botón
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                    IconButton(
                        onPressed: () {
                          editPizza();
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.green,
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagenPizza(String imagePath) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: NetworkImage(
              imagePath), // Usa NetworkImage para cargar la imagen desde una URL
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pizzas'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futurePizzas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay pizzas disponibles'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pizza = snapshot.data![index];
                return _buildPizzaCard(
                  pizza['nombre'] ?? 'Nombre no disponible',
                  pizza['imageUrl'] ??
                      'https://via.placeholder.com/200', // URL de imagen de respaldo si no se proporciona una
                  pizza['descripcion'] ?? 'Descripción no disponible',
                  pizza['precio'] != null
                      ? pizza['precio'].toString()
                      : 'Precio no disponible', // Convierte el precio en cadena si está presente
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _registerPizza(context),
        tooltip: 'Registrar Nueva Pizza',
        child: const Icon(Icons.add),
      ),
    );
  }
}
