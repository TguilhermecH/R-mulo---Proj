import 'package:flutter/material.dart';
import '../models/cachorro.dart';
import '../repository/CachorroRepository.dart';

class CachorroProvider extends ChangeNotifier {
  final CachorroRepository _repo = CachorroRepository();
  List<Cachorro> _cachorros = [];

  List<Cachorro> get cachorros => _cachorros;

  Future<void> carregarCachorros() async {
    _cachorros = await _repo.getAll();
    print('Cachorros carregados: ${_cachorros.map((c) => c.toMap()).toList()}');
    notifyListeners();
  }

  Future<void> adicionarCachorro(Cachorro cachorro) async {
    await _repo.save(cachorro, id: cachorro.id);
    await carregarCachorros();
  }
  Future<void> removerCachorro(String id) async {
    await _repo.delete(id);
    await carregarCachorros();
  }
  Future<void> editarCachorro(Cachorro cachorro) async {
    await _repo.save(cachorro, id: cachorro.id);
    await carregarCachorros();
  }
}