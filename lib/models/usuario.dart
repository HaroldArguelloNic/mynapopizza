import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String? id;
  final String name;
  final String correoElectronico;
  final String numeroTelefono;
  final String image;
  final String contrasenia;
  final String rol;

  Usuario({
    this.id,
    required this.name,
    required this.correoElectronico,
    required this.numeroTelefono,
    required this.contrasenia,
    required this.image,
    required this.rol,
  });

  // Convierte el objto o clase usuario a un map.
  Map<String, dynamic> toMap() {
    return {
      'uid':id,
      'nombre': name,
      'correoElectronico': correoElectronico,
      'contrasenia':contrasenia,
      'numeroTelefono': numeroTelefono,
      'image':image,
      'rol':rol,
    };
  }

  // Crea una instancia de Usuario a partir de un documento de Firestore
  Usuario.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        name = doc.data()!["nombre"],
        correoElectronico = doc.data()!["correoElectronico"],
        numeroTelefono = doc.data()!["numeroTelefono"],
        contrasenia = doc.data()!['contrasenia'],
        image=doc.data()!['image'],
        rol= doc.data()!['rol'];
}
