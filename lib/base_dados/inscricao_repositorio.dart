import 'package:sqflite/sqflite.dart';
import '../modelos/inscricao.dart';
import 'base_dados_helper.dart';

class InscricaoRepositorio {

  Future<void> inscrever(int estudanteId, int disciplinaId) async {
    bool jaInscrito = await estudanteJaInscrito(estudanteId, disciplinaId);
    if (jaInscrito) return;

    Database db = await BaseDadosHelper.getInstance();
    Inscricao i = Inscricao(
      estudanteId,
      disciplinaId,
      DateTime.now().toString(),
    );
    await db.insert('inscricoes', i.toMap());
  }

  Future<void> remover(int id) async {
    Database db = await BaseDadosHelper.getInstance();
    await db.delete(
      'inscricoes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Inscricao>> listarPorEstudante(int estudanteId) async {
    Database db = await BaseDadosHelper.getInstance();
    List<Map<String, dynamic>> resultado = await db.query(
      'inscricoes',
      where: 'estudanteId = ?',
      whereArgs: [estudanteId],
    );

    List<Inscricao> inscricoes = [];
    for (Map<String, dynamic> map in resultado) {
      inscricoes.add(Inscricao.fromMap(map));
    }
    return inscricoes;
  }

  Future<List<Inscricao>> listarPorDisciplina(int disciplinaId) async {
    Database db = await BaseDadosHelper.getInstance();
    List<Map<String, dynamic>> resultado = await db.query(
      'inscricoes',
      where: 'disciplinaId = ?',
      whereArgs: [disciplinaId],
    );

    List<Inscricao> inscricoes = [];
    for (Map<String, dynamic> map in resultado) {
      inscricoes.add(Inscricao.fromMap(map));
    }
    return inscricoes;
  }

  Future<bool> estudanteJaInscrito(int estudanteId, int disciplinaId) async {
    Database db = await BaseDadosHelper.getInstance();
    List<Map<String, dynamic>> resultado = await db.query(
      'inscricoes',
      where: 'estudanteId = ? AND disciplinaId = ?',
      whereArgs: [estudanteId, disciplinaId],
    );
    return resultado.isNotEmpty;
  }
}
