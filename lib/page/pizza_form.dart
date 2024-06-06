import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mynapopizza/models/pizza.dart';
import 'package:mynapopizza/services/obtener_imagen.dart';
import 'package:mynapopizza/services/pizza_service.dart';
import 'package:mynapopizza/services/subir_imagen.dart';

// Supongamos que estas funciones están definidas en otro lugar de tu código
// Future<XFile?> getImage() async { ... }
// Future<bool> uploadImage(File image) async { ... }
// Future<bool> agregarPizza(Pizza pizza) async { ... }

class PizzaForm extends StatefulWidget {
  const PizzaForm({super.key});

  @override
  State<PizzaForm> createState() => _PizzaFormState();
}

class _PizzaFormState extends State<PizzaForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nombrepizza = TextEditingController();
  final TextEditingController precio = TextEditingController();
  final TextEditingController rebanadas = TextEditingController();
  final TextEditingController tamanio = TextEditingController();
  final TextEditingController descripcion = TextEditingController();
  File? imageFile;

  Future<void> _pickImage() async {
    final XFile? pickedFile = await getImage();
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _savePizza() async {
    if (_formKey.currentState!.validate()) {
      if (imageFile != null) {
        bool uploadSuccess = await uploadImage(imageFile!);
        if (uploadSuccess) {
          final String imageUrl = await FirebaseStorage.instance
              .ref()
              .child('pizzas')
              .child(imageFile!.path.split('/').last)
              .getDownloadURL();

          final Pizza newPizza = Pizza(
            nombre: nombrepizza.text,
            descripcion: descripcion.text,
            precio: double.parse(precio.text),
            rebanadas: int.parse(rebanadas.text),
            tamanio: tamanio.text,
            imagenUrl: imageUrl,
          );

          bool addPizzaSuccess = await agregarPizza(newPizza);
          if (addPizzaSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Pizza guardada con éxito')),
            );
            _formKey.currentState!.reset();
            setState(() {
              imageFile = null;
              nombrepizza.clear();
              precio.clear();
              rebanadas.clear();
              tamanio.clear();
              descripcion.clear();
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error al guardar la pizza')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al subir la imagen')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor seleccione una imagen')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Pizza'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nombrepizza,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre de la pizza';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: descripcion,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la descripción';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: precio,
                  decoration: const InputDecoration(labelText: 'Precio'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el precio';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Por favor ingrese un número válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: rebanadas,
                  decoration: const InputDecoration(labelText: 'Rebanadas'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el número de rebanadas';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor ingrese un número válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: tamanio,
                  decoration: const InputDecoration(labelText: 'Tamaño'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el tamaño de la pizza';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                imageFile == null
                    ? const Text('No se ha seleccionado ninguna imagen')
                    : Image.file(imageFile!, height: 200),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Seleccionar Imagen'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _savePizza,
                  child: const Text('Guardar Pizza'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
