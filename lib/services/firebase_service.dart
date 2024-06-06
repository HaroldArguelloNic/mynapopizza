import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Map<String, dynamic>>> getUsuarios() async {
  List<Map<String, dynamic>> usuarios = [];
  try {
    CollectionReference collectionReferenceUsuarios = db.collection('usuarios');
    QuerySnapshot queryUsuarios = await collectionReferenceUsuarios.get();
    usuarios = queryUsuarios.docs.map((documento) => documento.data() as Map<String, dynamic>).toList();
  } catch (e) {
    print("Error al obtener los usuarios: $e");
  }
  return usuarios;
}
