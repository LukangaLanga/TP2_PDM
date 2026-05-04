import 'package:flutter/material.dart';
import '../../modelos/estudante.dart';
import '../../modelos/disciplina.dart';

class FormularioInscricao extends StatelessWidget {
  final Disciplina disciplina;
  final List<Estudante> estudantesDisponiveis;
  final Function(Estudante) onInscrever;

  const FormularioInscricao({
    super.key,
    required this.disciplina,
    required this.estudantesDisponiveis,
    required this.onInscrever,
  });

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
            'Inscrever Estudante',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Disciplina: ${disciplina.nome}',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ...estudantesDisponiveis.map((e) => ListTile(
                leading: Icon(Icons.person_add, color: Colors.blue[900]),
                title: Text(e.nome),
                subtitle: Text(e.curso),
                onTap: () {
                  Navigator.pop(context);
                  onInscrever(e);
                },
              )),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
