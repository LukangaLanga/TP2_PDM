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
  int _totalAvaliacoes = 0;
  int _totalInscricoes = 0;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    print("a carregar resumo...");
    final estudantes = await Locator.estudante.listarTodos();
    final disciplinas = await Locator.disciplina.listarTodos();

    int totalAvaliacoes = 0;
    int totalInscricoes = 0;
    for (var d in disciplinas) {
      final avs = await Locator.avaliacao.listarPorDisciplina(d.id!);
      final insc = await Locator.inscricao.listarPorDisciplina(d.id!);
      totalAvaliacoes += avs.length;
      totalInscricoes += insc.length;
    }

    setState(() {
      _totalEstudantes = estudantes.length;
      _totalDisciplinas = disciplinas.length;
      _totalAvaliacoes = totalAvaliacoes;
      _totalInscricoes = totalInscricoes;
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
            const Text('Resumo geral', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            Row(
              children: [
                _CardResumo(titulo: 'Estudantes', valor: _totalEstudantes, icone: Icons.people),
                const SizedBox(width: 16),
                _CardResumo(titulo: 'Disciplinas', valor: _totalDisciplinas, icone: Icons.book),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _CardResumo(titulo: 'Avaliações', valor: _totalAvaliacoes, icone: Icons.assignment),
                const SizedBox(width: 16),
                _CardResumo(titulo: 'Inscrições', valor: _totalInscricoes, icone: Icons.how_to_reg),
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
              Text(titulo, style: const TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
