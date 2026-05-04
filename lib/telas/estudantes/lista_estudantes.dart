import 'package:flutter/material.dart';
import '../../modelos/estudante.dart';

class ListaEstudantes extends StatelessWidget {
  final List<Estudante> estudantes;
  final Function(Estudante) onEditar;
  final Function(int) onRemover;

  const ListaEstudantes({
    super.key,
    required this.estudantes,
    required this.onEditar,
    required this.onRemover,
  });

  @override
  Widget build(BuildContext context) {
    if (estudantes.isEmpty) {
      return const Center(child: Text('Nenhum estudante encontrado'));
    }
    return ListView.builder(
      itemCount: estudantes.length,
      itemBuilder: (context, index) {
        Estudante e = estudantes[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Icon(Icons.person, color: Colors.blue[900]),
            title: Text(e.nome),
            subtitle: Text('${e.email} | ${e.curso}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue[900]),
                  onPressed: () => onEditar(e),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onRemover(e.id!),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
