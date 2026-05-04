import 'package:flutter/material.dart';
import '../../modelos/inscricao.dart';
import '../../modelos/estudante.dart';

class ListaInscricoes extends StatelessWidget {
  final List<Inscricao> inscricoes;
  final List<Estudante> estudantes;
  final Function(Inscricao) onRemover;

  const ListaInscricoes({
    super.key,
    required this.inscricoes,
    required this.estudantes,
    required this.onRemover,
  });

  String _nomeEstudante(Inscricao i) {
    final matches = estudantes.where((e) => e.id == i.estudanteId);
    return matches.isEmpty ? 'Desconhecido' : matches.first.nome;
  }

  @override
  Widget build(BuildContext context) {
    if (inscricoes.isEmpty) {
      return const Center(child: Text('Nenhum estudante inscrito nesta disciplina.'));
    }
    return ListView.builder(
      itemCount: inscricoes.length,
      itemBuilder: (context, index) {
        final i = inscricoes[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: ListTile(
            leading: Icon(Icons.person, color: Colors.blue[900]),
            title: Text(_nomeEstudante(i)),
            subtitle: Text('Inscrito em: ${i.dataInscricao.substring(0, 10)}'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () => onRemover(i),
            ),
          ),
        );
      },
    );
  }
}
