import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/receta_controller.dart';
import 'views/inicio_screen.dart';
import 'views/home_screen.dart';
import 'views/add_receta_screen.dart';
import 'utils/translations.dart';

// 👇 Importar esto solo si vas a correr en Windows/Linux/Mac
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {

  // Inicializar sqflite para FFI (escritorio)
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  Get.put(RecetaController()); // controlador inyectado
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Recetario Profesional',
      translations: MyTranslations(),
      locale: const Locale('es', 'ES'),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.amber,
          brightness: Brightness.light,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.blue[900],
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue[900],
        colorScheme: ColorScheme.dark(
          primary: Colors.blue[900]!,
          secondary: Colors.amber,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.blue[900],
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/inicio',
      getPages: [
        GetPage(name: '/inicio', page: () => const InicioScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/add', page: () => const AddRecetaScreen()),
      ],
    );
  }
}
