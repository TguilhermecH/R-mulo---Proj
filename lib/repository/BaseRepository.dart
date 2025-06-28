import 'package:sembast/sembast.dart';

import 'appdatabase.dart';

abstract class BaseRepository<T> {
  final StoreRef<String, Map<String, dynamic>> _store;
 
  BaseRepository(String storeName) : _store = stringMapStoreFactory.store(storeName);
 
  Future<Database> get _db async => await AppDatabase().database;
 
  // Converte um objeto para Map
  Map<String, dynamic> toMap(T item);
 
  // Converte um Map para objeto
  T fromMap(Map<String, dynamic> map);
 
  // Adiciona ou atualiza um item
  Future<String> save(T item, {String? id}) async {
    final db = await _db;
    if (id == null) {
      return await _store.add(db, toMap(item));
    } else {
      await _store.record(id).put(db, toMap(item));
      return id;
    }
  }
 
  // Busca um item por ID
  Future<T?> get(String id) async {
    final db = await _db;
    final record = await _store.record(id).get(db);
    return record != null ? fromMap(record) : null;
  }
 
  // Busca todos os itens
  Future<List<T>> getAll() async {
    final db = await _db;
    final records = await _store.find(db);
    return records.map((snapshot) => fromMap(snapshot.value)).toList();
  }
 
  // Remove um item
  Future<void> delete(String id) async {
    final db = await _db;
    await _store.record(id).delete(db);
  }
 
  // Remove todos os itens
  Future<void> deleteAll() async {
    final db = await _db;
    await _store.delete(db);
  }
 
  // Busca com filtros
  Future<List<T>> find(Finder finder) async {
    final db = await _db;
    final records = await _store.find(db, finder: finder);
    return records.map((snapshot) => fromMap(snapshot.value)).toList();
  }
}