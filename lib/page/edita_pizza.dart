import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mynapopizza/utils/text_box.dart';

class EditaPizza extends StatefulWidget {
  const EditaPizza({super.key, required this.idPizza});

  @override
  State<EditaPizza> createState() => _EditaPizzaState();
  final String idPizza;
}

class _EditaPizzaState extends State<EditaPizza> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200],
      appBar: AppBar(
        title: const Text('Edicion de Producto'),
        backgroundColor: Colors.orange[100],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pizzas')
            .doc(widget.idPizza)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final pizzadata = snapshot.data?.data() as Map<String, dynamic>;
            return ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(pizzadata[
                          'imageUrl']), // Usa NetworkImage para cargar la imagen desde una URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextBox(
                    text: pizzadata['nombre'],
                    sectionName: 'Nombre',
                    onPressed: () => editfield('nombre')),
                MyTextBox(
                    text: pizzadata['descripcion'],
                    sectionName: 'Descripcion',
                    onPressed: () => editfield('descripcion')),
                MyTextBox(
                    text: pizzadata['precio'].toString(),
                    sectionName: 'Precio',
                    onPressed: () => editfield('precio')),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Eror${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
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
    if (newValue.contains(RegExp(r'[A-Z]'))) {
      if (newValue.trim().isNotEmpty) {
        await pizzaCollection.doc(widget.idPizza).update({field: newValue});
      }
    } else {
      double newValor = double.parse(newValue);
      await pizzaCollection.doc(widget.idPizza).update({field: newValor});
    }
  }
}
