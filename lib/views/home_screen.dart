import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/receta_controller.dart';
import '../widgets/receta_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecetaController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'home_title'.tr,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        backgroundColor:
            Theme.of(context).brightness == Brightness.dark ? Colors.black87 : Colors.white,
        elevation: 4,
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        actions: [
          // Botón de cambio de tema
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              Get.changeTheme(
                Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
              );
            },
            tooltip: 'Cambiar tema',
          ),
          // Botón de cambio de idioma
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              Get.bottomSheet(
                Container(
                  color: isDark ? Colors.black87 : Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.flag, color: isDark ? Colors.white : Colors.black),
                        title: Text(
                          'Español',
                          style: TextStyle(color: isDark ? Colors.white : Colors.black),
                        ),
                        onTap: () {
                          Get.updateLocale(const Locale('es', 'ES'));
                          Get.back();
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.flag, color: isDark ? Colors.white : Colors.black),
                        title: Text(
                          'English',
                          style: TextStyle(color: isDark ? Colors.white : Colors.black),
                        ),
                        onTap: () {
                          Get.updateLocale(const Locale('en', 'US'));
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            tooltip: 'Cambiar idioma',
          ),
        ],
      ),


      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Obx(() {
          if (controller.recetas.isEmpty) {
            return Center(
                child: Text(
              'No hay recetas',
              style: TextStyle(color: Colors.amber, fontSize: 20),
            ));
          }
          return ListView.builder(
            itemCount: controller.recetas.length,
            itemBuilder: (context, index) {
              final receta = controller.recetas[index];
              return RecetaCard(
                receta: receta,
                onDelete: () => controller.deleteReceta(receta.id!),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.blue[900],
        onPressed: () => Get.toNamed('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
