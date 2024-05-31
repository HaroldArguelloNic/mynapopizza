import 'package:flutter/material.dart';

class ProductoPage extends StatefulWidget {
  const ProductoPage({Key? key}) : super(key: key);

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  List<String> pizzas = []; // Lista vacía para pizzas

  void _editPizza(int index) {
    // Lógica para editar una pizza falta desarrollo
    setState(() {
      _showToast(context, "Desarrollo de la edición en proceso");
    });
  }

  void _registerPizza() {
    // Lógica para registrar una nueva pizza Falta desarrollo
    setState(() {
      _showToast(context, "Desarrollo del formulario en proceso");
    });
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildPizzaCard(String pizza, String pizzaImage, int index) {
    return Container(
      alignment: Alignment.center,
      height: 200,
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
        children: [
          _imagenPizza(pizzaImage),
          const SizedBox(width: 20.0),
          Expanded(
            child: Text(
              pizza,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.blue),
            onPressed: () => _editPizza(index),
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
          image: AssetImage(imagePath),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: pizzas.length,
          itemBuilder: (context, index) {
            return _buildPizzaCard(pizzas[index], 'assets/pizza.png', index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _registerPizza,
        child: Icon(Icons.add),
        tooltip: 'Registrar Nueva Pizza',
      ),
    );
  }
}
