import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<Map<String, dynamic>>> getUsuarios() async {
  List<Map<String, dynamic>> usuarios = [];
  try {
    CollectionReference collectionReferenceUsuarios = db.collection('usuarios');
    QuerySnapshot queryUsuarios = await collectionReferenceUsuarios.get();
    usuarios = queryUsuarios.docs
        .map((documento) => documento.data() as Map<String, dynamic>)
        .toList();
  } catch (e) {
    Text("Error al obtener los usuarios: $e");
  }
  return usuarios;
}
