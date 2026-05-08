import 'package:sqflite/sqflite.dart';
import '../modelos/disciplina.dart';
import 'base_dados_helper.dart';

class DisciplinaRepositorio {

  Future<void> adicionar(Disciplina d) async {
    print("a adicionar disciplina: ${d.nome}");
    Database db = await BaseDadosHelper.getInstance();
    await db.insert('disciplinas', d.toMap());
  }

  Future<void> editar(Disciplina d) async {
    Database db = await BaseDadosHelper.getInstance();
    await db.update(
      'disciplinas',
      d.toMap(),
      where: 'id = ?',
      whereArgs: [d.id],
    );
    print("disciplina editada");
  }

  Future<void> remover(int id) async {
    print("a remover disciplina id: $id");
    Database db = await BaseDadosHelper.getInstance();
    await db.delete(
      'disciplinas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Disciplina>> listarTodos() async {
    print("a carregar disciplinas...");
    Database db = await BaseDadosHelper.getInstance();
    List<Map<String, dynamic>> resultado = await db.query('disciplinas');

    List<Disciplina> disciplinas = [];
    for (Map<String, dynamic> map in resultado) {
      disciplinas.add(Disciplina.fromMap(map));
    }
    print("total: ${disciplinas.length}");
    return disciplinas;
  }

  Future<Disciplina?> buscarPorId(int id) async {
    Database db = await BaseDadosHelper.getInstance();
    List<Map<String, dynamic>> resultado = await db.query(
      'disciplinas',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultado.isEmpty) {
      return null;
    }
    return Disciplina.fromMap(resultado[0]);
  }
}
