import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repository/cachorro_provider.dart';
import 'EditarCachorroScreen.dart';

class ListaCachorrosScreen extends StatelessWidget {

@override
Widget build(BuildContext context) {
  final cachorros = Provider.of<CachorroProvider>(context).cachorros;
return Scaffold(
appBar: AppBar(title: Text('Cães Cadastrados')),
body: cachorros.isEmpty
? Center(child: Text('Nenhum cachorro cadastrado.'))
: ListView.builder(
itemCount: cachorros.length,
itemBuilder: (_, i) {
final c = cachorros[i];
return ListTile(
  leading: Image.network(
    c.imagemUrl,
    width: 50, height: 50, fit: BoxFit.cover
  ),
  title: Text(c.nome),
  subtitle: Text('Raça: ${c.raca}\nResponsável: ${c.responsavel}'),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
  IconButton(
    icon: Icon(Icons.delete, color: Colors.red),
    onPressed: () async {
      await Provider.of<CachorroProvider>(context, listen: false).removerCachorro(c.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cachorro removido com sucesso!'))
      );
    },
  ),
  IconButton(
    icon: Icon(Icons.edit, color: Colors.blue),
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => EditarCachorroScreen(cachorro: c),
      ));
    },
  ),]
  ),
  );
          },
        ),
  );
}
}