import 'package:get/get.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'es_ES': {
          'home_title': 'Recetas',
          'add_title': 'Agregar Receta',
          'nombre': 'Nombre',
          'descripcion': 'Descripción',
          'agregar': 'Agregar',
          'cancelar': 'Cancelar',
        },
        'en_US': {
          'home_title': 'Recipes',
          'add_title': 'Add Recipe',
          'nombre': 'Name',
          'descripcion': 'Description',
          'agregar': 'Add',
          'cancelar': 'Cancel',
        },
      };
}
