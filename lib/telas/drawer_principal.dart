import 'package:flutter/material.dart';
import 'tela_inicial.dart';
import 'estudantes/estudantes_tela.dart';
import 'disciplinas/disciplinas_tela.dart';
import 'avaliacoes/avaliacoes_tela.dart';
import 'notas/notas_tela.dart';

class DrawerPrincipal extends StatelessWidget {
  const DrawerPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // cabeçalho
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue[900]),
            child: const SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school, color: Colors.white, size: 48),
                  SizedBox(height: 8),
                  Text(
                    'Gestão de Notas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // itens do menu
          _ItemDrawer(
            icone: Icons.home,
            titulo: 'Início',
            destino: const TelaInicial(),
          ),
          _ItemDrawer(
            icone: Icons.people,
            titulo: 'Estudantes',
            destino: const EstudantesTela(),
          ),
          _ItemDrawer(
            icone: Icons.book,
            titulo: 'Disciplinas',
            destino: const DisciplinasTela(),
          ),
          _ItemDrawer(
            icone: Icons.assignment,
            titulo: 'Avaliações',
            destino: const AvaliacoesTela(),
          ),
          _ItemDrawer(
            icone: Icons.grade,
            titulo: 'Notas',
            destino: const NotasTela(),
          ),
        ],
      ),
    );
  }
}

class _ItemDrawer extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final Widget destino;

  const _ItemDrawer({
    required this.icone,
    required this.titulo,
    required this.destino,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icone, color: Colors.blue[900]),
      title: Text(titulo),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => destino),
        );
      },
    );
  }
}
