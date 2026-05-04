import 'package:flutter/material.dart';
import '../../base_dados/locator.dart';
import '../../modelos/disciplina.dart';
import '../../modelos/estudante.dart';
import '../../modelos/inscricao.dart';
import '../drawer_principal.dart';
import 'lista_inscricoes.dart';
import 'formulario_inscricao.dart';

class InscricoesTela extends StatefulWidget {
  const InscricoesTela({super.key});

  @override
  State<InscricoesTela> createState() => _InscricoesTelaState();
}

class _InscricoesTelaState extends State<InscricoesTela> {
  List<Disciplina> _disciplinas           = [];
  List<Estudante>  _estudantes            = [];
  List<Inscricao>  _inscricoes            = [];
  Disciplina?      _disciplinaSelecionada;

  @override
  void initState() {
    super.initState();
    _carregarInicial();
  }

  Future<void> _carregarInicial() async {
    final disciplinas = await Locator.disciplina.listarTodos();
    final estudantes  = await Locator.estudante.listarTodos();
    setState(() {
      _disciplinas = disciplinas;
      _estudantes  = estudantes;
      if (disciplinas.isNotEmpty) _disciplinaSelecionada = disciplinas.first;
    });
    await _carregarInscricoes();
  }

  Future<void> _carregarInscricoes() async {
    if (_disciplinaSelecionada == null) return;
    final inscricoes = await Locator.inscricao.listarPorDisciplina(_disciplinaSelecionada!.id!);
    setState(() => _inscricoes = inscricoes);
  }

  Future<void> _inscrever(Estudante estudante) async {
    await Locator.inscricao.inscrever(estudante.id!, _disciplinaSelecionada!.id!);
    await _carregarInscricoes();
  }

  Future<void> _remover(Inscricao inscricao) async {
    await Locator.inscricao.remover(inscricao.id!);
    await _carregarInscricoes();
  }

  List<Estudante> get _estudantesDisponiveis {
    final inscritos = _inscricoes.map((i) => i.estudanteId).toSet();
    return _estudantes.where((e) => !inscritos.contains(e.id)).toList();
  }

  void _abrirFormulario() {
    final disponiveis = _estudantesDisponiveis;
    if (disponiveis.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos os estudantes já estão inscritos nesta disciplina.')),
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => FormularioInscricao(
        disciplina:            _disciplinaSelecionada!,
        estudantesDisponiveis: disponiveis,
        onInscrever:           _inscrever,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscrições'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      drawer: const DrawerPrincipal(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<Disciplina>(
              value: _disciplinaSelecionada,
              decoration: const InputDecoration(
                labelText: 'Disciplina',
                border: OutlineInputBorder(),
              ),
              items: _disciplinas.map((d) {
                return DropdownMenuItem(value: d, child: Text(d.nome));
              }).toList(),
              onChanged: (d) {
                setState(() => _disciplinaSelecionada = d);
                _carregarInscricoes();
              },
            ),
          ),
          Expanded(
            child: ListaInscricoes(
              inscricoes: _inscricoes,
              estudantes: _estudantes,
              onRemover:  _remover,
            ),
          ),
        ],
      ),
      floatingActionButton: _disciplinaSelecionada != null
          ? FloatingActionButton(
              backgroundColor: Colors.blue[900],
              onPressed: _abrirFormulario,
              child: const Icon(Icons.person_add, color: Colors.white),
            )
          : null,
    );
  }
}
