import 'package:flutter/material.dart';
import '../../base_dados/locator.dart';
import '../../modelos/nota.dart';
import '../../modelos/inscricao.dart';
import '../../modelos/avaliacao.dart';
import '../../modelos/disciplina.dart';
import '../../modelos/estudante.dart';
import '../drawer_principal.dart';
import 'lista_notas.dart';
import 'formulario_nota.dart';

class NotasTela extends StatefulWidget {
  const NotasTela({super.key});

  @override
  State<NotasTela> createState() => _NotasTelaState();
}

class _NotasTelaState extends State<NotasTela> {
  List<Disciplina> _disciplinas           = [];
  List<Nota>       _notas                 = [];
  List<Inscricao>  _inscricoes            = [];
  List<Avaliacao>  _avaliacoes            = [];
  List<Estudante>  _estudantes            = [];
  Disciplina?      _disciplinaSelecionada;

  @override
  void initState() {
    super.initState();
    _carregarInicial();
  }

  Future<void> _carregarInicial() async {
    List<Disciplina> disciplinas = await Locator.disciplina.listarTodos();
    List<Estudante>  estudantes  = await Locator.estudante.listarTodos();
    setState(() {
      _disciplinas = disciplinas;
      _estudantes  = estudantes;
      if (disciplinas.isNotEmpty) _disciplinaSelecionada = disciplinas.first;
    });
    await _carregarPorDisciplina();
  }

  Future<void> _carregarPorDisciplina() async {
    if (_disciplinaSelecionada == null) return;
    int disciplinaId = _disciplinaSelecionada!.id!;

    List<Nota>      notas      = await Locator.nota.listarPorDisciplina(disciplinaId);
    List<Inscricao> inscricoes = await Locator.inscricao.listarPorDisciplina(disciplinaId);
    List<Avaliacao> avaliacoes = await Locator.avaliacao.listarPorDisciplina(disciplinaId);

    setState(() {
      _notas      = notas;
      _inscricoes = inscricoes;
      _avaliacoes = avaliacoes;
    });
  }

  Future<void> _atribuir(Nota n) async {
    await Locator.nota.atribuirNota(n.inscricaoId, n.avaliacaoId, n.valor);
    await _carregarPorDisciplina();
  }

  Future<void> _editar(Nota n) async {
    await Locator.nota.editarNota(n.id!, n.valor);
    await _carregarPorDisciplina();
  }

  void _abrirFormulario({Nota? nota}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => FormularioNota(
        nota:       nota,
        inscricoes: _inscricoes,
        avaliacoes: _avaliacoes,
        estudantes: _estudantes,
        onGuardar: (n) {
          Navigator.pop(context);
          if (nota == null) {
            _atribuir(n);
          } else {
            _editar(n);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas'),
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
                _carregarPorDisciplina();
              },
            ),
          ),
          Expanded(
            child: ListaNotas(
              notas:       _notas,
              inscricoes:  _inscricoes,
              avaliacoes:  _avaliacoes,
              estudantes:  _estudantes,
              onEditar:    (n) => _abrirFormulario(nota: n),
            ),
          ),
        ],
      ),
      floatingActionButton: _disciplinaSelecionada != null
          ? FloatingActionButton(
              backgroundColor: Colors.blue[900],
              onPressed: () => _abrirFormulario(),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}
