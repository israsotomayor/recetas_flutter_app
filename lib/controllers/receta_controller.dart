import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/receta.dart';
import '../services/db_service.dart';

class RecetaController extends GetxController {
  final DBService dbService = DBService();
  var recetas = <Receta>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRecetas();
  }

  void loadRecetas() async {
    recetas.value = await dbService.getRecetas();
  }

  void addReceta(Receta receta) async {
    
    try {
      await dbService.addReceta(receta);
      loadRecetas();
      Get.snackbar('Éxito', 'Receta agregada correctamente');
    } catch (e) {
      print('Error al agregar receta: $e');
      Get.snackbar(
        "Error BD",
        "No se pudo guardar la receta",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }

    
  }

  void deleteReceta(int id) async {
    bool confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Confirmar'),
        content: const Text('¿Deseas eliminar esta receta?'),
        actions: [
          TextButton(onPressed: () => Get.back(result: false), child: const Text('No')),
          TextButton(onPressed: () => Get.back(result: true), child: const Text('Sí')),
        ],
      ),
    ) ?? false;

    if (confirm) {
      await dbService.deleteReceta(id);
      loadRecetas();
      Get.snackbar('Éxito', 'Receta eliminada');
    }
  }
}
