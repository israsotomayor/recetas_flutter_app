import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/receta.dart';

class DBService {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'recetas.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE recetas(id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, descripcion TEXT, pasos TEXT)',
        );
      },
    );
  }

  Future<List<Receta>> getRecetas() async {
    final db = await database;
    final maps = await db.query('recetas');
    return List.generate(maps.length, (i) => Receta.fromMap(maps[i]));
  }

  Future<void> addReceta(Receta receta) async {
    final db = await database;
    await db.insert('recetass', receta.toMap());
  }

  Future<void> deleteReceta(int id) async {
    final db = await database;
    await db.delete('recetas', where: 'id = ?', whereArgs: [id]);
  }
}
