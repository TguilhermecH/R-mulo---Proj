import 'package:dog_adoption_app/models/cachorro.dart';
import 'package:dog_adoption_app/repository/CachorroRepository.dart';
import 'package:dog_adoption_app/repository/cachorro_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repository/ThemeProvider.dart';
import 'screens/home_screen.dart';

void main() {
runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => CachorroProvider()..carregarCachorros()),
  ],
  
  child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static _MyAppState of(BuildContext context) {
    return context.findAncestorStateOfType<_MyAppState>()!;
  }

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
final CachorroRepository _cachorroRepository = CachorroRepository();

@override
void initState() {
  super.initState();
  _loadCachorros();
}
Future<void> _loadCachorros() async {
  final cachorros = await _cachorroRepository.getAll();
  setState(() {
  });
}

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Adoção de Cães',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}