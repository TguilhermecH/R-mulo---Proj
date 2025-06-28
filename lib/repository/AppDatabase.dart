import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class AppDatabase {
  // Nome do banco de dados
  static const String dbName = 'my_app.db';
 
  // Singleton instance
  static final AppDatabase _singleton = AppDatabase._();
 
  // Construtor privado
  AppDatabase._();
 
  // Factory constructor
  factory AppDatabase() {
    return _singleton;
  }
 
  // Referência do banco de dados
  Database? _database;
 
  Future<Database> get database async {
    if (_database != null) return _database!;
   
    // Abre o banco de dados
    _database = await _openDatabase();
    return _database!;
  }
 
  Future<Database> _openDatabase() async {
    // Verifica se está na web
    if (_isWeb()) {
      // Usa o Sembast para Web
      return await databaseFactoryWeb.openDatabase(dbName);
    } else {
      // Usa o Sembast com Sqflite para mobile/desktop
      final appDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDir.path, dbName);
     
      // Cria o banco de dados
      final database = await databaseFactoryIo.openDatabase(dbPath);
     
      return database;
    }
  }
 
  bool _isWeb() {
    return identical(1, 1.0);
  }
 
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}

