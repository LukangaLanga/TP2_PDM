import 'package:flutter/material.dart';
import '../../modelos/avaliacao.dart';

// AvaliacaoRepositorio não tem editar — só remover
class ListaAvaliacoes extends StatelessWidget {
  final List<Avaliacao> avaliacoes;
  final Function(int) onRemover;

  const ListaAvaliacoes({
    super.key,
    required this.avaliacoes,
    required this.onRemover,
  });

  @override
  Widget build(BuildContext context) {
    if (avaliacoes.isEmpty) {
      return const Center(child: Text('Nenhuma avaliação encontrada'));
    }
    return ListView.builder(
      itemCount: avaliacoes.length,
      itemBuilder: (context, index) {
        Avaliacao a = avaliacoes[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Icon(Icons.assignment, color: Colors.blue[900]),
            title: Text(a.nome),
            subtitle: Text('Peso: ${a.peso.toStringAsFixed(1)}%'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => onRemover(a.id!),
            ),
          ),
        );
      },
    );
  }
}
