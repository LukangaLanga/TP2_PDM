import 'package:flutter/material.dart';
import '../../base_dados/locator.dart';
import '../../modelos/disciplina.dart';
import '../drawer_principal.dart';
import 'lista_disciplinas.dart';
import 'formulario_disciplina.dart';

class DisciplinasTela extends StatefulWidget {
  const DisciplinasTela({super.key});

  @override
  State<DisciplinasTela> createState() => _DisciplinasTelaState();
}

class _DisciplinasTelaState extends State<DisciplinasTela> {
  List<Disciplina> _disciplinas = [];

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    List<Disciplina> lista = await Locator.disciplina.listarTodos();
    setState(() => _disciplinas = lista);
  }

  Future<void> _adicionar(Disciplina d) async {
    await Locator.disciplina.adicionar(d);
    await _carregar();
  }

  Future<void> _editar(Disciplina d) async {
    await Locator.disciplina.editar(d);
    await _carregar();
  }

  Future<void> _remover(int id) async {
    await Locator.disciplina.remover(id);
    await _carregar();
  }

  void _abrirFormulario({Disciplina? disciplina}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => FormularioDisciplina(
        disciplina: disciplina,
        onGuardar: (d) {
          Navigator.pop(context);
          if (disciplina == null) {
            _adicionar(d);
          } else {
            _editar(d);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disciplinas'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      drawer: const DrawerPrincipal(),
      body: ListaDisciplinas(
        disciplinas: _disciplinas,
        onEditar: (d) => _abrirFormulario(disciplina: d),
        onRemover: _remover,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () => _abrirFormulario(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
