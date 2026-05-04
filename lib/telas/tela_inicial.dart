import 'package:flutter/material.dart';
import '../base_dados/locator.dart';
import 'drawer_principal.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int _totalEstudantes = 0;
  int _totalDisciplinas = 0;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    final estudantes = await Locator.estudante.listarTodos();
    final disciplinas = await Locator.disciplina.listarTodos();
    setState(() {
      _totalEstudantes = estudantes.length;
      _totalDisciplinas = disciplinas.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Início'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      drawer: const DrawerPrincipal(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo ao Sistema',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Resumo geral',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _CardResumo(
                  titulo: 'Estudantes',
                  valor: _totalEstudantes,
                  icone: Icons.people,
                ),
                const SizedBox(width: 16),
                _CardResumo(
                  titulo: 'Disciplinas',
                  valor: _totalDisciplinas,
                  icone: Icons.book,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CardResumo extends StatelessWidget {
  final String titulo;
  final int valor;
  final IconData icone;

  const _CardResumo({
    required this.titulo,
    required this.valor,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.blue[900],
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(icone, color: Colors.white, size: 40),
              const SizedBox(height: 12),
              Text(
                '$valor',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                titulo,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
