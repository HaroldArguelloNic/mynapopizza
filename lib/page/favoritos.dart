import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynapopizza/services/login_provider.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({super.key});

  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
   User? user;

  @override
  void initState() {
    super.initState();
    // Obtener el usuario actual utilizando Provider
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    user = loginProvider.getCurrentUser();
  }

  // Función para mostrar un toast
  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        content: Text("Función en desarrollo"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Función para obtener las pizzas favoritas del usuario
  Future<List<Map<String, dynamic>>> obtenerPizzasFavoritas(String uidUsuario) async {
    try {
      DocumentSnapshot usuarioDoc = await FirebaseFirestore.instance.collection('usuarios').doc(uidUsuario).get();
      List<String> favoritasUids = List<String>.from(usuarioDoc.get('favoritePizzas') ?? []);

      if (favoritasUids.isEmpty) return [];

      List<Map<String, dynamic>> favoritas = [];
      for (String uid in favoritasUids) {
        DocumentSnapshot pizzaDoc = await FirebaseFirestore.instance.collection('pizzas').doc(uid).get();
        if (pizzaDoc.exists) {
          favoritas.add(pizzaDoc.data() as Map<String, dynamic>);
        }
      }

      return favoritas;
    } catch (e) {
      print("Ocurrió un error al obtener las pizzas favoritas: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: obtenerPizzasFavoritas(user!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              ); // Muestra un indicador de carga mientras se obtiene la lista de pizzas favoritas
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error al obtener las pizzas favoritas: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No se encontraron pizzas favoritas'),
              );
            } else {
              return ListView(
                children: snapshot.data!.map((pizza) {
                  return _buildPizzaCard(
                    pizza['nombre'] ?? 'Nombre no disponible',
                    pizza['imageUrl'] ?? 'https://via.placeholder.com/200',
                    pizza['descripcion'] ?? 'Descripción no disponible',
                    pizza['precio'].toString() ?? '0',
                    pizza['uid'] ?? '00000',
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildPizzaCard(String nombre, String imageUrl, String descripcion, String precio, String pizzaUid) {
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
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: _imagenPizza(imageUrl),
          ),
          const SizedBox(width: 10), // Espacio entre la imagen y el contenido
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  nombre,
                  textAlign: TextAlign.center, // Centra el texto
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5), // Espacio entre el nombre y el precio
                Text(
                  'Precio: \$${precio}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green, // Cambia el color del texto del precio
                    fontWeight: FontWeight.bold, // Utiliza una fuente en negrita para resaltarlo
                  ),
                ),
                const SizedBox(height: 5), // Espacio entre el precio y la descripción
                Text(
                  'Descripción: $descripcion',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10), // Espacio entre la descripción y el botón
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      // Aquí puedes agregar la lógica para eliminar de favoritos
                      _showToast(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagenPizza(String pizzaImage) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Image.network(
        pizzaImage,
        fit: BoxFit.cover,
      ),
    );
  }
}
