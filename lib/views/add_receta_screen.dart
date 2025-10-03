import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/receta_controller.dart';
import '../models/receta.dart';

class AddRecetaScreen extends StatefulWidget {
  const AddRecetaScreen({super.key});

  @override
  State<AddRecetaScreen> createState() => _AddRecetaScreenState();
}

class _AddRecetaScreenState extends State<AddRecetaScreen> {
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final RecetaController controller = Get.find();
  List<TextEditingController> _pasosControllers = [TextEditingController()];

  void _agregarPaso() {
    setState(() {
      _pasosControllers.add(TextEditingController());
    });
  }

  void _eliminarPaso(int index) {
    setState(() {
      _pasosControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('add_title'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'nombre'.tr),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descripcionController,
                decoration: InputDecoration(labelText: 'descripcion'.tr),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              const Text('Pasos', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ..._pasosControllers.asMap().entries.map((entry) {
                int idx = entry.key;
                TextEditingController ctrl = entry.value;
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: ctrl,
                        decoration: InputDecoration(
                          labelText: 'Paso ${idx + 1}',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _eliminarPaso(idx),
                    ),
                  ],
                );
              }),
              TextButton.icon(
                onPressed: _agregarPaso,
                icon: const Icon(Icons.add),
                label: const Text('Agregar Paso'),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final nombre = _nombreController.text.trim();
                      final descripcion = _descripcionController.text.trim();
                      final pasos = _pasosControllers.map((c) => c.text.trim()).where((p) => p.isNotEmpty).toList();

                      if (nombre.isEmpty || descripcion.isEmpty || pasos.isEmpty) {
                        Get.snackbar('Error', 'Completa todos los campos');
                        return;
                      }

                      controller.addReceta(
                        Receta(nombre: nombre, descripcion: descripcion, pasos: pasos),
                      );
                      Get.back();
                    },
                    child: Text('agregar'.tr),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: Text('cancelar'.tr),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
