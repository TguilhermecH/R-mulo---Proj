import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cachorro.dart';
import '../repository/cachorro_provider.dart';

class EditarCachorroScreen extends StatefulWidget {
  final Cachorro cachorro;

  EditarCachorroScreen({required this.cachorro});

  @override
  _EditarCachorroScreenState createState() => _EditarCachorroScreenState();
}

class _EditarCachorroScreenState extends State<EditarCachorroScreen> {
  late TextEditingController nomeController;
  late TextEditingController racaController;
  late TextEditingController responsavelController;
  late TextEditingController imagemUrlController;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.cachorro.nome);
    racaController = TextEditingController(text: widget.cachorro.raca);
    responsavelController = TextEditingController(
      text: widget.cachorro.responsavel,
    );
    imagemUrlController = TextEditingController(
      text: widget.cachorro.imagemUrl,
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    racaController.dispose();
    responsavelController.dispose();
    imagemUrlController.dispose();
    super.dispose();
  }

  void salvarAlteracoes() {
    final cachorroEditado = Cachorro(
      id: widget.cachorro.id,
      nome: nomeController.text,
      raca: racaController.text,
      responsavel: responsavelController.text,
      imagemUrl: imagemUrlController.text,
    );

    Provider.of<CachorroProvider>(
      context,
      listen: false,
    ).editarCachorro(cachorroEditado);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Cachorro',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        elevation: 4,
        shadowColor: Colors.black38,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: ListView(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: racaController,
              decoration: InputDecoration(
                labelText: 'Raça',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: responsavelController,
              decoration: InputDecoration(
                labelText: 'Responsável',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: imagemUrlController,
              decoration: InputDecoration(
                labelText: 'URL da Imagem',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceVariant,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: salvarAlteracoes,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: theme.colorScheme.primary,
                  elevation: 3,
                ),
                child: const Text(
                  'Salvar Alterações',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
