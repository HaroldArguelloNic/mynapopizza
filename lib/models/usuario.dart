import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String? id;
  final String nombre;
  final String correoElectronico;
  final String numeroTelefono;
  final String contrasenia;
  final String rol;

  Usuario({
    this.id,
    required this.nombre,
    required this.correoElectronico,
    required this.numeroTelefono,
    required this.contrasenia,
    required this.rol,
  });

  // Convierte el objto o clase usuario a un map.
  Map<String, dynamic> toMap() {
    return {
      'uid':id,
      'nombre': nombre,
      'correoElectronico': correoElectronico,
      'contrasenia':contrasenia,
      'numeroTelefono': numeroTelefono,
      'rol':rol,
    };
  }

  // Crea una instancia de Usuario a partir de un documento de Firestore
  Usuario.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        nombre = doc.data()!["nombre"],
        correoElectronico = doc.data()!["correoElectronico"],
        numeroTelefono = doc.data()!["numeroTelefono"],
        contrasenia = doc.data()!['contrasenia'],
        rol= doc.data()!['rol'];
}
