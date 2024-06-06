import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Pizza {
  final String? id;
  final String nombre;
  final double precio;
  final int rebanadas;
  final String tamanio;
  final String descripcion;
  final String imagenUrl;

  Pizza({
    this.id,
    required this.nombre,
    required this.precio,
    required this.rebanadas,
    required this.tamanio,
    required this.descripcion,
    required this.imagenUrl,
  });

  // Convierte el objto o clase pizza a un map.
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'precio': precio,
      'rebanadas': rebanadas,
      'tamanio': tamanio,
      'descripcion': descripcion,
      'imangeUrl':imagenUrl,
    };
  }

  // Crea una instancia de Pizza a partir de un documento de Firestore
  Pizza.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        nombre = doc.data()!["nombre"],
        precio = doc.data()!["precio"],
        rebanadas = doc.data()!["rebanadas"],
        tamanio = doc.data()!["tamanio"],
        descripcion = doc.data()!["descripcion"],
        imagenUrl= doc.data()!['imagenUrl'];
}
