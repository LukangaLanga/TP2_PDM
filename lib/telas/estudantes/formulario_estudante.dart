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
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cursoController = TextEditingController();

  String? _erroNome;
  String? _erroEmail;
  String? _erroCurso;

  @override
  void initState() {
    super.initState();
    if (widget.estudante != null) {
      _nomeController.text = widget.estudante!.nome;
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
    String nome = _nomeController.text.trim();
    String email = _emailController.text.trim();
    String curso = _cursoController.text.trim();

    // verifica se está vazio
    setState(() {
      _erroNome = nome.isEmpty ? 'O nome não pode estar vazio' : null;
      _erroEmail = email.isEmpty ? 'O email não pode estar vazio' : null;
      _erroCurso = curso.isEmpty ? 'O curso não pode estar vazio' : null;
    });

    if (nome.isEmpty || email.isEmpty || curso.isEmpty) {
      return;
    }

    print("a guardar estudante...");

    if (widget.estudante != null) {
      widget.estudante!.nome = nome;
      widget.estudante!.email = email;
      widget.estudante!.curso = curso;
      widget.onGuardar(widget.estudante!);
    } else {
      widget.onGuardar(Estudante(nome, email, curso));
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
            decoration: InputDecoration(
              labelText: 'Nome',
              border: const OutlineInputBorder(),
              errorText: _erroNome,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: const OutlineInputBorder(),
              errorText: _erroEmail,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _cursoController,
            decoration: InputDecoration(
              labelText: 'Curso',
              border: const OutlineInputBorder(),
              errorText: _erroCurso,
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
