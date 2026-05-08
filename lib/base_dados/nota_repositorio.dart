import 'package:sqflite/sqflite.dart';
import '../modelos/nota.dart';
import '../modelos/inscricao.dart';
import 'base_dados_helper.dart';
import 'inscricao_repositorio.dart';

class NotaRepositorio {

  Future<void> atribuirNota(int inscricaoId, int avaliacaoId, double valor) async {
    print("a guardar nota $valor...");
    Database db = await BaseDadosHelper.getInstance();
    Nota n = Nota(inscricaoId, avaliacaoId, valor, '');
    await db.insert('notas', n.toMap());
  }

  Future<void> editarNota(int notaId, double novoValor) async {
    print("a editar nota $notaId para $novoValor");
    Database db = await BaseDadosHelper.getInstance();
    await db.update(
      'notas',
      {'valor': novoValor},
      where: 'id = ?',
      whereArgs: [notaId],
    );
  }

  Future<List<Nota>> listarPorInscricao(int inscricaoId) async {
    Database db = await BaseDadosHelper.getInstance();
    List<Map<String, dynamic>> resultado = await db.query(
      'notas',
      where: 'inscricaoId = ?',
      whereArgs: [inscricaoId],
    );

    List<Nota> notas = [];
    for (Map<String, dynamic> map in resultado) {
      notas.add(Nota.fromMap(map));
    }
    return notas;
  }

  Future<List<Nota>> listarPorDisciplina(int disciplinaId) async {
    print("a carregar notas da disciplina $disciplinaId...");
    InscricaoRepositorio inscricaoRepo = InscricaoRepositorio();
    List<Inscricao> inscricoes = await inscricaoRepo.listarPorDisciplina(disciplinaId);

    List<Nota> notas = [];
    for (Inscricao i in inscricoes) {
      List<Nota> notasDaInscricao = await listarPorInscricao(i.id!);
      for (Nota n in notasDaInscricao) {
        notas.add(n);
      }
    }
    return notas;
  }

  Future<double> calcularMediaPorDisciplina(int disciplinaId) async {
    List<Nota> notas = await listarPorDisciplina(disciplinaId);
    if (notas.isEmpty) {
      return 0.0;
    }

    double soma = 0.0;
    for (Nota n in notas) {
      soma += n.valor;
    }
    double media = soma / notas.length;
    print("media: $media");
    return media;
  }
}
