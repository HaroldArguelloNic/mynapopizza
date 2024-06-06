import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mynapopizza/services/pizza_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(224, 132, 46, 0.71),
                  ),
                  child: Text('Menu')),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.blue,
                  ),
                  title: const Text(
                    'home',
                    style: TextStyle(color: Colors.indigo),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => Navigator.pushNamed(context,'/home'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.favorite_rounded,
                    color: Colors.red,
                  ),
                  title: const Text(
                    'Favoritos',
                    style: TextStyle(color: Colors.indigo),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => Navigator.pushNamed(context, '/favoritos'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.local_pizza,
                    color: Colors.amber,
                  ),
                  title: const Text(
                    'Producto',
                    style: TextStyle(color: Colors.indigo),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => Navigator.pushNamed(context, '/producto'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.playlist_add_check_circle,
                    color: Colors.green,
                  ),
                  title: const Text(
                    'Mi Orden',
                    style: TextStyle(color: Colors.indigo),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => Navigator.pushNamed(context, '/miorden'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.man,
                    color: Colors.purple,
                  ),
                  title: const Text(
                    'Mi Perfil',
                    style: TextStyle(color: Colors.indigo),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => Navigator.pushNamed(context, '/miperfil'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  leading: const Icon(
                    Icons.man,
                    color: Colors.lightBlue,
                  ),
                  title: const Text(
                    'Usuarios',
                    style: TextStyle(color: Colors.lightBlue),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => Navigator.pushNamed(context, '/usuarios'),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'MyNapoPizza',
            style: TextStyle(color: Colors.green),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Tipo Pizzas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 100, // Altura fija para la fila de tipos
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildTypeCard('Pizza Grande'),
                    _buildTypeCard('Pizza Pequeña'),
                    _buildTypeCard('Pizza Mediana'),
                    _buildTypeCard('Pizza Especial'),
                    _buildTypeCard('Personalizada'),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Pizzas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Column(
                children: [
                  FutureBuilder<List<DocumentSnapshot>>(
                    future: listaPizzas(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtiene la lista de pizzas
                      } else if (snapshot.hasError) {
                        return Text('Error al obtener las pizzas: ${snapshot.error}');
                      } else {
                        return Column(
                          children: snapshot.data!.map((pizza) => _buildPizzaCard(pizza['name'], pizza['imageUrl'])).toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //card para los tipos de pizza
  Widget _buildTypeCard(String type) {
    return Container(
      width: 200, // Ancho fijo para cada tarjeta de tipo
      height: 100, //ALto
      margin: const EdgeInsets.all(8.0),
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
      child: Center(
        child: Text(
          type,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  //card para las  pizzas
  Widget _buildPizzaCard(String pizza, String pizzaimage) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      width: 800,
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
        children: [
          _imagenPizza(pizzaimage),
          Text(
            pizza,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 20),
          // Botón de "Me gusta" (corazón)
          IconButton(
                       icon: const Icon(Icons.favorite_outline),
            color: Colors.red,
            onPressed: () {
              _showToast(context); // Mostrar toast cuando se hace clic
            },
          ),
        ],
      ),
    );
  }

  Widget _imagenPizza(String pizzaimage) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Image.network(
        pizzaimage,
        fit: BoxFit.cover,
      ),
    );
  }
}

