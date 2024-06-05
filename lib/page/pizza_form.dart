import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PizzaForm extends StatefulWidget {
  const PizzaForm ({super.key});
  @override
  State<PizzaForm>  createState() => _PizzaFormState();
}

class _PizzaFormState extends State<PizzaForm> {
  final _formKey = GlobalKey<FormState>();
  String? nombre;
  String? descripcion;
  File? imageFile;
  double? precio;
  int? slices;

  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
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
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre de la pizza';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    nombre = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la descripción';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    descripcion = value;
                  },
                ),
                TextFormField(
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
                  onSaved: (value) {
                    precio = double.parse(value!);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Slices'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el número de slices';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor ingrese un número válido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    slices = int.parse(value!);
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Aquí iría la lógica para guardar la pizza
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pizza guardada con éxito')),
                      );
                      _formKey.currentState!.reset();
                      setState(() {
                        imageFile = null;
                      });
                    }
                  },
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
