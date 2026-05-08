import 'package:flutter/material.dart';
import '../../modelos/disciplina.dart';

class ListaDisciplinas extends StatelessWidget {
  final List<Disciplina> disciplinas;
  final Map<int, double?> medias;
  final Function(Disciplina) onEditar;
  final Function(int) onRemover;

  const ListaDisciplinas({
    super.key,
    required this.disciplinas,
    required this.medias,
    required this.onEditar,
    required this.onRemover,
  });

  @override
  Widget build(BuildContext context) {
    if (disciplinas.isEmpty) {
      return const Center(child: Text('Nenhuma disciplina encontrada'));
    }

    return ListView.builder(
      itemCount: disciplinas.length,
      itemBuilder: (context, index) {
        Disciplina d = disciplinas[index];
        double? media = medias[d.id];

        Widget mediaWidget;
        if (media == null) {
          mediaWidget = const Text(
            'Sem notas',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          );
        } else {
          // verde >= 10, vermelho < 10
          Color cor = media >= 10 ? Colors.green : Colors.red;
          mediaWidget = Text(
            'Média: ${media.toStringAsFixed(1)}',
            style: TextStyle(color: cor, fontSize: 12, fontWeight: FontWeight.bold),
          );
        }

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Icon(Icons.book, color: Colors.blue[900]),
            title: Text(d.nome),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${d.cargaHoraria}h | ${d.descricao}'),
                mediaWidget,
              ],
            ),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue[900]),
                  onPressed: () => onEditar(d),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onRemover(d.id!),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
