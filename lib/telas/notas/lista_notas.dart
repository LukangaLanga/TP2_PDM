import 'package:flutter/material.dart';
import '../../modelos/nota.dart';
import '../../modelos/inscricao.dart';
import '../../modelos/avaliacao.dart';
import '../../modelos/estudante.dart';

// NotaRepositorio não tem remover — só editar
class ListaNotas extends StatelessWidget {
  final List<Nota>      notas;
  final List<Inscricao> inscricoes;
  final List<Avaliacao> avaliacoes;
  final List<Estudante> estudantes;
  final Function(Nota)  onEditar;

  const ListaNotas({
    super.key,
    required this.notas,
    required this.inscricoes,
    required this.avaliacoes,
    required this.estudantes,
    required this.onEditar,
  });

  String _nomeEstudante(int inscricaoId) {
    final matches = inscricoes.where((i) => i.id == inscricaoId);
    if (matches.isEmpty) return 'Desconhecido';
    final estudanteMatches = estudantes.where((e) => e.id == matches.first.estudanteId);
    if (estudanteMatches.isEmpty) return 'Desconhecido';
    return estudanteMatches.first.nome;
  }

  String _nomeAvaliacao(int avaliacaoId) {
    final matches = avaliacoes.where((a) => a.id == avaliacaoId);
    return matches.isEmpty ? 'Desconhecida' : matches.first.nome;
  }

  @override
  Widget build(BuildContext context) {
    if (notas.isEmpty) {
      return const Center(child: Text('Nenhuma nota encontrada'));
    }
    return ListView.builder(
      itemCount: notas.length,
      itemBuilder: (context, index) {
        Nota n = notas[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Icon(Icons.grade, color: Colors.blue[900]),
            title: Text(_nomeEstudante(n.inscricaoId)),
            subtitle: Text(
              '${_nomeAvaliacao(n.avaliacaoId)} | Nota: ${n.valor.toStringAsFixed(1)}',
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit, color: Colors.blue[900]),
              onPressed: () => onEditar(n),
            ),
          ),
        );
      },
    );
  }
}
