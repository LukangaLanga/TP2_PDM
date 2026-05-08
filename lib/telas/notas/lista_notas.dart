import 'package:flutter/material.dart';
import '../../modelos/nota.dart';
import '../../modelos/inscricao.dart';
import '../../modelos/avaliacao.dart';
import '../../modelos/estudante.dart';

class ListaNotas extends StatelessWidget {
  final List<Nota> notas;
  final List<Inscricao> inscricoes;
  final List<Avaliacao> avaliacoes;
  final List<Estudante> estudantes;
  final Function(Nota) onEditar;

  const ListaNotas({
    super.key,
    required this.notas,
    required this.inscricoes,
    required this.avaliacoes,
    required this.estudantes,
    required this.onEditar,
  });

  String _nomeEstudante(int inscricaoId) {
    final insc = inscricoes.where((i) => i.id == inscricaoId);
    if (insc.isEmpty) {
      return 'Desconhecido';
    }
    final est = estudantes.where((e) => e.id == insc.first.estudanteId);
    if (est.isEmpty) {
      return 'Desconhecido';
    }
    return est.first.nome;
  }

  String _nomeAvaliacao(int avaliacaoId) {
    final av = avaliacoes.where((a) => a.id == avaliacaoId);
    if (av.isEmpty) {
      return 'Desconhecida';
    }
    return av.first.nome;
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
        // verde >= 10, vermelho < 10
        Color cor = n.valor >= 10 ? Colors.green : Colors.red;
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Icon(Icons.grade, color: cor),
            title: Text(_nomeEstudante(n.inscricaoId)),
            subtitle: Text(
              '${_nomeAvaliacao(n.avaliacaoId)} | Nota: ${n.valor.toStringAsFixed(1)}',
              style: TextStyle(color: cor, fontWeight: FontWeight.bold),
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
