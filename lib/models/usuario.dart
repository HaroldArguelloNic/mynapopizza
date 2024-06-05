import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String? id;
  final String nombre;
  final String correoElectronico;
  final String numeroTelefono;
  final String contrasenia;

  Usuario({
    this.id,
    required this.nombre,
    required this.correoElectronico,
    required this.numeroTelefono,
    required this.contrasenia,
  });

  // Convierte el objto o clase usuario a un map.
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'correoElectronico': correoElectronico,
      'contrasenia':contrasenia,
      'numeroTelefono': numeroTelefono,
    };
  }

  // Crea una instancia de Usuario a partir de un documento de Firestore
  Usuario.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        nombre = doc.data()!["nombre"],
        correoElectronico = doc.data()!["correoElectronico"],
        numeroTelefono = doc.data()!["numeroTelefono"],
        contrasenia = doc.data()!['contrasenia'];
}
