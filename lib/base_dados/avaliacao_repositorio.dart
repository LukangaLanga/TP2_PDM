import 'package:sqflite/sqflite.dart';
import '../modelos/avaliacao.dart';
import 'base_dados_helper.dart';

class AvaliacaoRepositorio {

  Future<void> adicionar(Avaliacao a) async {
    Database db = await BaseDadosHelper.getInstance();
    await db.insert('avaliacoes', a.toMap());
  }

  Future<void> remover(int id) async {
    Database db = await BaseDadosHelper.getInstance();
    await db.delete(
      'avaliacoes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Avaliacao>> listarPorDisciplina(int disciplinaId) async {
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
