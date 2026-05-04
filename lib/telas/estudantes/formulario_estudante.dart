import 'package:flutter/material.dart';
import '../../modelos/estudante.dart';

class FormularioEstudante extends StatefulWidget {
  final Estudante? estudante;
  final Function(Estudante) onGuardar;

  const FormularioEstudante({
    super.key,
    this.estudante,
    required this.onGuardar,
  });

  @override
  State<FormularioEstudante> createState() => _FormularioEstudanteState();
}

class _FormularioEstudanteState extends State<FormularioEstudante> {
  final TextEditingController _nomeController  = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cursoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.estudante != null) {
      _nomeController.text  = widget.estudante!.nome;
      _emailController.text = widget.estudante!.email;
      _cursoController.text = widget.estudante!.curso;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cursoController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (widget.estudante != null) {
      widget.estudante!.nome  = _nomeController.text;
      widget.estudante!.email = _emailController.text;
      widget.estudante!.curso = _cursoController.text;
      widget.onGuardar(widget.estudante!);
    } else {
      Estudante e = Estudante(
        _nomeController.text,
        _emailController.text,
        _cursoController.text,
      );
      widget.onGuardar(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.estudante == null ? 'Novo Estudante' : 'Editar Estudante',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _cursoController,
            decoration: const InputDecoration(
              labelText: 'Curso',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: _guardar,
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
