import 'package:flutter/material.dart';
import 'base_dados/base_dados_helper.dart';
import 'telas/tela_inicial.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BaseDadosHelper.getInstance();
  runApp(const GestaoNotasApp());
}

class GestaoNotasApp extends StatelessWidget {
  const GestaoNotasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestão de Notas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        useMaterial3: true,
      ),
      home: const TelaInicial(),
    );
  }
}
