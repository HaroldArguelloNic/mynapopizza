import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              // agregar una fila horizontal para los tipos
              Container(
                height: 100, // Altura fija para la fila de tipos
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildTypeCard('Type 1'),
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
                  _buildPizzaCard('Pizza 1'),
                  _buildPizzaCard('Pizza 2'),
                  _buildPizzaCard('Pizza 3'),
                  _buildPizzaCard('Pizza 4'),
                  _buildPizzaCard('Pizza 5'),
                  _buildPizzaCard('Pizza 5'),
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
      width: 110, // Ancho fijo para cada tarjeta de tipo
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
  Widget _buildPizzaCard(String pizza) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
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
          const Icon(Icons.local_pizza, size: 60, color: Colors.orange),
          const SizedBox(width: 16.0),
          Text(
            pizza,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
