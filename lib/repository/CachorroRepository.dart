import 'package:dog_adoption_app/models/cachorro.dart';
import 'package:sembast/sembast.dart';

import 'baserepository.dart';

class CachorroRepository extends BaseRepository<Cachorro> {
  CachorroRepository() : super('cachorros');
 
  @override
  Cachorro fromMap(Map<String, dynamic> map) {
    return Cachorro(
      id: map['id'] as String,
      nome: map['nome'] as String,
      raca: map['raca'] as String,
      responsavel: map['responsavel'] as String,
      imagemUrl: map['imagemUrl'] as String,
    );
  }
 
  @override
  Map<String, dynamic> toMap(Cachorro item) {
    return {
      'id': item.id,
      'nome': item.nome,
      'raca': item.raca,
      'responsavel': item.responsavel,
      'imagemUrl': item.imagemUrl
    };
  }
 
  // Métodos específicos para tarefas
  Future<List<Cachorro>> getCompletedTasks() async {
    final finder = Finder(
      filter: Filter.equals('completed', true),
      sortOrders: [SortOrder('createdAt', false)],
    );
    return find(finder);
  }
 
  Future<List<Cachorro>> getPendingTasks() async {
    final finder = Finder(
      filter: Filter.equals('completed', false),
      sortOrders: [SortOrder('createdAt', false)],
    );
    return find(finder);
  }
}