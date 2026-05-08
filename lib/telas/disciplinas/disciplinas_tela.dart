import 'package:flutter/material.dart';
import '../../base_dados/locator.dart';
import '../../modelos/disciplina.dart';
import '../../modelos/nota.dart';
import '../drawer_principal.dart';
import 'lista_disciplinas.dart';
import 'formulario_disciplina.dart';

class DisciplinasTela extends StatefulWidget {
  const DisciplinasTela({super.key});

  @override
  State<DisciplinasTela> createState() => _DisciplinasTelaState();
}

class _DisciplinasTelaState extends State<DisciplinasTela> {
  List<Disciplina>  _disciplinas = [];
  // médias por id da disciplina — null se não houver notas
  Map<int, double?> _medias      = {};

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  // carrega disciplinas e calcula a média de notas de cada uma
  Future<void> _carregar() async {
    List<Disciplina> lista = await Locator.disciplina.listarTodos();
    Map<int, double?> medias = {};

    for (var d in lista) {
      List<Nota> notas = await Locator.nota.listarPorDisciplina(d.id!);
      if (notas.isEmpty) {
        medias[d.id!] = null;
      } else {
        double soma = notas.fold(0.0, (sum, n) => sum + n.valor);
        medias[d.id!] = soma / notas.length;
      }
    }

    setState(() {
      _disciplinas = lista;
      _medias      = medias;
    });
  }

  Future<void> _adicionar(Disciplina d) async {
    await Locator.disciplina.adicionar(d);
    await _carregar();
  }

  Future<void> _editar(Disciplina d) async {
    await Locator.disciplina.editar(d);
    await _carregar();
  }

  // pede confirmação antes de remover a disciplina
  Future<void> _remover(int id) async {
    bool confirmar = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Remover Disciplina'),
            content: const Text('Tem a certeza que quer remover esta disciplina?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Remover', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;

    if (confirmar) {
      await Locator.disciplina.remover(id);
      await _carregar();
    }
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
        medias:      _medias,
        onEditar:    (d) => _abrirFormulario(disciplina: d),
        onRemover:   _remover,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () => _abrirFormulario(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
