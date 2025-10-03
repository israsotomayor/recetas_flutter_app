import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          SizedBox.expand(
            child: Image.asset(
              'assets/images/cocina.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          // Capa semi-transparente
          Container(color: Colors.black.withOpacity(0.4)),
          // Contenido central
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Mi Recetario Profesional',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 6,
                        color: Colors.black54,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () => Get.toNamed('/home'),
                  child: const Text('Ver Recetas'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
