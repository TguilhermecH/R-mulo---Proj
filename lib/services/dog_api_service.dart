import 'dart:convert';
import 'package:http/http.dart' as http;

class DogApiService {
static Future<List<String>> getRacas() async {
final response =
await http.get(Uri.parse('https://dog.ceo/api/breeds/list/all'));
if (response.statusCode == 200) {
final data = jsonDecode(response.body);
return (data['message'] as Map<String, dynamic>).keys.toList();
} else {
throw Exception('Erro ao buscar raças');
}
}

static Future<String> getImagemPorRaca(String raca) async {
final response = await http
.get(Uri.parse('https://dog.ceo/api/breed/$raca/images/random'));
if (response.statusCode == 200) {
final data = jsonDecode(response.body);
return data['message'];
} else {
throw Exception('Erro ao buscar imagem');
}
}
}