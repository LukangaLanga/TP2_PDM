import 'package:sqflite/sqflite.dart';
import '../modelos/estudante.dart';
import 'base_dados_helper.dart';

class EstudanteRepositorio {

  Future<void> adicionar(Estudante e) async {
    Database db = await BaseDadosHelper.getInstance();
    await db.insert('estudantes', e.toMap());
  }

  Future<void> editar(Estudante e) async {
    Database db = await BaseDadosHelper.getInstance();
    await db.update(
      'estudantes',
      e.toMap(),
      where: 'id = ?',
      whereArgs: [e.id],
    );
  }

  Future<void> remover(int id) async {
    Database db = await BaseDadosHelper.getInstance();
    await db.delete(
      'estudantes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Estudante>> listarTodos() async {
    Database db = await BaseDadosHelper.getInstance();
    List<Map<String, dynamic>> resultado = await db.query('estudantes');

    List<Estudante> estudantes = [];
    for (Map<String, dynamic> map in resultado) {
      estudantes.add(Estudante.fromMap(map));
    }
    return estudantes;
  }

  Future<Estudante?> buscarPorId(int id) async {
    Database db = await BaseDadosHelper.getInstance();
    List<Map<String, dynamic>> resultado = await db.query(
      'estudantes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultado.isEmpty) return null;
    return Estudante.fromMap(resultado[0]);
  }
}
