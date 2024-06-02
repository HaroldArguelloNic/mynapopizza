import 'package:flutter/material.dart';


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
                  onTap: () => Navigator.pushNamed(context,'/favoritos'),
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
                  onTap: () => Navigator.pushNamed(context,'/producto'),
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
                  onTap: () => Navigator.pushNamed(context,'/miorden'),
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
                  onTap: () => Navigator.pushNamed(context,'/miperfil'),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        //drawer:SideBar(),
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
              // agregar una fila horizontal para los tipos
              SizedBox(
                height: 100, // Altura fija para la fila de tipos
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildTypeCard('Pizza Grande'),
                    _buildTypeCard('Type 2'),
                    _buildTypeCard('Type 3'),
                    _buildTypeCard('Type 4'),
                    _buildTypeCard('Type 5'),
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
              //  agregar una columna vertical para las pizzas
              Column(
                children: [
                  _buildPizzaCard('Pizza 1', 'pizzaJamon.jpg'),
                  _buildPizzaCard('Pizza 2', 'pizzaHawaina.jpg'),
                  _buildPizzaCard('Pizza 3', 'pizzaPeperoni.jpg'),
                  _buildPizzaCard('Pizza 4', 'pizzaSalami.jpg'),
                  _buildPizzaCard('Pizza 5', 'PizzasSuperNapo.jpg'),
                  _buildPizzaCard('Pizza 6', 'PizzaFullCarne.jpg'),
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
          //const Icon(Icons.local_pizza, size: 60, color: Colors.orange),
          //const SizedBox(width: 55.0, height: 180,),
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
      child: Image(
        fit: BoxFit.scaleDown,
        image: AssetImage('assets/$pizzaimage'),
        width: 200,
        height: 200,
      ),
    );
  }
}
