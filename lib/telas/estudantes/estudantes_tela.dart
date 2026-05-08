import 'package:flutter/material.dart';
import '../../base_dados/locator.dart';
import '../../modelos/estudante.dart';
import '../drawer_principal.dart';
import 'lista_estudantes.dart';
import 'formulario_estudante.dart';

class EstudantesTela extends StatefulWidget {
  const EstudantesTela({super.key});

  @override
  State<EstudantesTela> createState() => _EstudantesTelaState();
}

class _EstudantesTelaState extends State<EstudantesTela> {
  // lista de estudantes
  List<Estudante> _estudantes = [];

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    print("a carregar estudantes...");
    List<Estudante> lista = await Locator.estudante.listarTodos();
    setState(() {
      _estudantes = lista;
    });
  }

  Future<void> _adicionar(Estudante e) async {
    await Locator.estudante.adicionar(e);
    await _carregar();
  }

  Future<void> _editar(Estudante e) async {
    await Locator.estudante.editar(e);
    await _carregar();
  }

  // pede confirmação e remove
  Future<void> _remover(int id) async {
    bool confirmar = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Remover Estudante'),
            content: const Text('Tem a certeza que quer remover este estudante?'),
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
      await Locator.estudante.remover(id);
      await _carregar();
    }
  }

  // abre o form
  void _abrirFormulario({Estudante? estudante}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => FormularioEstudante(
        estudante: estudante,
        onGuardar: (e) {
          Navigator.pop(context);
          if (estudante == null) {
            _adicionar(e);
          } else {
            _editar(e);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estudantes'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      drawer: const DrawerPrincipal(),
      body: ListaEstudantes(
        estudantes: _estudantes,
        onEditar: (e) => _abrirFormulario(estudante: e),
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
