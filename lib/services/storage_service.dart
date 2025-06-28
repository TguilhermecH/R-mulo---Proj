import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cachorro.dart';

class StorageService {
static const String chave = 'cachorros';

static Future<void> salvarCachorro(Cachorro c) async {
final prefs = await SharedPreferences.getInstance();
final lista = await getCachorros();
lista.add(c);
final jsonList = lista.map((e) => jsonEncode(e.toMap())).toList();
prefs.setStringList(chave, jsonList);
}

static Future<List<Cachorro>> getCachorros() async {
final prefs = await SharedPreferences.getInstance();
final jsonList = prefs.getStringList(chave) ?? [];
return jsonList.map((e) => Cachorro.fromMap(jsonDecode(e))).toList();
}
}