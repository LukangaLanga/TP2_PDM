import 'package:sqflite/sqflite.dart';
import '../modelos/avaliacao.dart';
import 'base_dados_helper.dart';

class AvaliacaoRepositorio {

  Future<void> adicionar(Avaliacao a) async {
    print("a adicionar avaliacao: ${a.nome}");

    Database db = await BaseDadosHelper.getInstance();

    List<Map<String, dynamic>> existe = await db.query(
      'avaliacoes',
      where: 'LOWER(nome) = ? AND disciplinaId = ?',
      whereArgs: [a.nome.toLowerCase(), a.disciplinaId],
    );

    if (existe.isNotEmpty) {
      print("A avaliação já existe nesta disciplina");
      return;
    }

    await db.insert('avaliacoes', a.toMap());
  }

  Future<void> remover(int id) async {
    print("a remover avaliacao id: $id");
    Database db = await BaseDadosHelper.getInstance();
    await db.delete(
      'avaliacoes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Avaliacao>> listarPorDisciplina(int disciplinaId) async {
    print("a carregar avaliacoes da disciplina $disciplinaId");
    Database db = await BaseDadosHelper.getInstance();
    List<Map<String, dynamic>> resultado = await db.query(
      'avaliacoes',
      where: 'disciplinaId = ?',
      whereArgs: [disciplinaId],
    );

    List<Avaliacao> avaliacoes = [];
    for (Map<String, dynamic> map in resultado) {
      avaliacoes.add(Avaliacao.fromMap(map));
    }
    return avaliacoes;
  }
}
