import 'package:flutter/material.dart';
import '../../base_dados/locator.dart';
import '../../modelos/avaliacao.dart';
import '../../modelos/disciplina.dart';
import '../drawer_principal.dart';
import 'lista_avaliacoes.dart';
import 'formulario_avaliacao.dart';

class AvaliacoesTela extends StatefulWidget {
  const AvaliacoesTela({super.key});

  @override
  State<AvaliacoesTela> createState() => _AvaliacoesTelaState();
}

class _AvaliacoesTelaState extends State<AvaliacoesTela> {
  List<Disciplina> _disciplinas    = [];
  List<Avaliacao>  _avaliacoes     = [];
  Disciplina?      _disciplinaSelecionada;

  @override
  void initState() {
    super.initState();
    _carregarDisciplinas();
  }

  Future<void> _carregarDisciplinas() async {
    List<Disciplina> lista = await Locator.disciplina.listarTodos();
    setState(() {
      _disciplinas = lista;
      if (lista.isNotEmpty) _disciplinaSelecionada = lista.first;
    });
    await _carregarAvaliacoes();
  }

  Future<void> _carregarAvaliacoes() async {
    if (_disciplinaSelecionada == null) return;
    List<Avaliacao> lista = await Locator.avaliacao
        .listarPorDisciplina(_disciplinaSelecionada!.id!);
    setState(() => _avaliacoes = lista);
  }

  Future<void> _adicionar(Avaliacao a) async {
    await Locator.avaliacao.adicionar(a);
    await _carregarAvaliacoes();
  }

  Future<void> _remover(int id) async {
    await Locator.avaliacao.remover(id);
    await _carregarAvaliacoes();
  }

  void _abrirFormulario() {
    if (_disciplinaSelecionada == null) return;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => FormularioAvaliacao(
        disciplinaId: _disciplinaSelecionada!.id!,
        onGuardar: (a) {
          Navigator.pop(context);
          _adicionar(a);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliações'),
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
                _carregarAvaliacoes();
              },
            ),
          ),
          Expanded(
            child: ListaAvaliacoes(
              avaliacoes: _avaliacoes,
              onRemover: _remover,
            ),
          ),
        ],
      ),
      floatingActionButton: _disciplinaSelecionada != null
          ? FloatingActionButton(
              backgroundColor: Colors.blue[900],
              onPressed: _abrirFormulario,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}
