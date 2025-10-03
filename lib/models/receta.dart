import 'dart:convert';

class Receta {
  int? id;
  String nombre;
  String descripcion;
  List<String> pasos;

  Receta({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.pasos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'pasos': jsonEncode(pasos),
    };
  }

  factory Receta.fromMap(Map<String, dynamic> map) {
    return Receta(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      pasos: map['pasos'] != null
          ? List<String>.from(jsonDecode(map['pasos']))
          : [],
    );
  }
}