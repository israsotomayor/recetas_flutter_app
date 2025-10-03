import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:recetas_app/controllers/receta_controller.dart';
import 'package:recetas_app/views/home_screen.dart';

  // 👇 Importar esto solo si vas a correr en Windows/Linux/Mac
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {

  // Inicializar sqflite para FFI (escritorio)
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  setUp(() {
    if (!Get.isRegistered<RecetaController>()) {
      Get.put(RecetaController());
      print('RecetaController inicializado');
    }
  });

  testWidgets('HomeScreen carga correctamente', (WidgetTester tester) async {
    print('Iniciando test: HomeScreen carga correctamente');

    await tester.pumpWidget(
      GetMaterialApp(home: const HomeScreen()),
    );

    print('Widget construido');

    // Verificar título del AppBar
    expect(find.text('home_title'.tr), findsOneWidget);
    print('Título del AppBar encontrado');

    // Verificar iconos
    expect(find.byIcon(Icons.brightness_6), findsOneWidget);
    print('Icono de cambio de tema encontrado');

    expect(find.byIcon(Icons.language), findsOneWidget);
    print('Icono de idioma encontrado');

    // Verificar FloatingActionButton
    expect(find.byType(FloatingActionButton), findsOneWidget);
    print('FloatingActionButton encontrado');
  });

  testWidgets('Al tocar el icono de idioma se abre BottomSheet', (WidgetTester tester) async {
    print('Iniciando test: abrir BottomSheet de idioma');

    await tester.pumpWidget(
      GetMaterialApp(home: const HomeScreen()),
    );

    // Tocar icono de idioma
    await tester.tap(find.byIcon(Icons.language));
    await tester.pumpAndSettle();
    print('Icono de idioma tocado y BottomSheet abierto');

    // Verificar opciones de idioma
    expect(find.text('Español'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    print('Opciones de idioma encontradas');
  });

  testWidgets('Se puede cambiar el tema con el icono de tema', (WidgetTester tester) async {
    print('Iniciando test: cambio de tema');

    await tester.pumpWidget(
      GetMaterialApp(home: const HomeScreen()),
    );

    // Tocar el icono de tema
    await tester.tap(find.byIcon(Icons.brightness_6));
    await tester.pumpAndSettle();
    print('Icono de tema tocado');

    // Solo comprobamos que el icono sigue presente
    expect(find.byIcon(Icons.brightness_6), findsOneWidget);
    print('Cambio de tema ejecutado sin errores');
  });
}
