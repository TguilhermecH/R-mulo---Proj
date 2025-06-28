import 'package:flutter/material.dart';
import '../models/cachorro.dart';
import '../services/dog_api_service.dart';
import 'package:provider/provider.dart';
import '../repository/cachorro_provider.dart';

class CadastroCachorroScreen extends StatefulWidget {
  CadastroCachorroScreen({Key? key}) : super(key: key);

  @override
  _CadastroCachorroScreenState createState() => _CadastroCachorroScreenState();
}

class _CadastroCachorroScreenState extends State<CadastroCachorroScreen> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final responsavelController = TextEditingController();
  String? racaSelecionada;
  List<String> racas = [];

  @override
  void initState() {
    super.initState();
    DogApiService.getRacas().then((r) {
      setState(() => racas = r);
    });
  }

  void salvar() async {
    if (!_formKey.currentState!.validate() || racaSelecionada == null) return;

    String imagem = await DogApiService.getImagemPorRaca(racaSelecionada!);
    Cachorro c = Cachorro(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nome: nomeController.text,
      raca: racaSelecionada!,
      imagemUrl: imagem,
      responsavel: responsavelController.text,
    );

    await Provider.of<CachorroProvider>(
      context,
      listen: false,
    ).adicionarCachorro(c);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastrar Cachorro',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        elevation: 4,
        shadowColor: Colors.black38,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: racas.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: nomeController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surfaceVariant,
                      ),
                      validator: (v) =>
                          v!.isEmpty ? 'Informe o nome do cão' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: racaSelecionada,
                      decoration: InputDecoration(
                        labelText: 'Raça',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surfaceVariant,
                      ),
                      items: racas
                          .map(
                            (r) => DropdownMenuItem(child: Text(r), value: r),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => racaSelecionada = v),
                      validator: (v) => v == null ? 'Selecione uma raça' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: responsavelController,
                      decoration: InputDecoration(
                        labelText: 'Responsável',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surfaceVariant,
                      ),
                      validator: (v) =>
                          v!.isEmpty ? 'Informe o responsável' : null,
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: salvar,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          backgroundColor: theme.colorScheme.primary,
                          elevation: 3,
                        ),
                        child: const Text(
                          'Salvar',
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
      ),
    );
  }
}
