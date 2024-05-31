import 'package:flutter/material.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({Key? key}) : super(key: key);

  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  List<String> favoritos = []; // Lista para almacenar las pizzas favoritas

  // Función para agregar una pizza como favorita automáticamente
  void agregarPizzaFavorita(String pizza) {
    setState(() {
      favoritos.add(pizza);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Aquí están tus pizzas favoritas:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            // Lista de favoritos (widget mutable)
            Expanded(
              child: favoritos.isEmpty // Si no hay favoritos, mostrar un mensaje
                  ? Center(
                      child: Text(
                        'No hay pizzas favoritas',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: favoritos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.favorite, color: Colors.red),
                          title: Text(favoritos[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}


