import '../modelos/nota.dart';
import '../modelos/inscricao.dart';
import '../operacoes/inscricao_operacoes.dart';

class NotaOperacoes {
  static List<Nota> _notas = [];

  static void atribuirNota(int inscricaoId, int avaliacaoId, double valor) {
    Nota n = Nota(inscricaoId, avaliacaoId, valor, '');
    _notas.add(n);
  }

  static void editarNota(int notaId, double novoValor) {
    for (int i = 0; i < _notas.length; i++) {
      if (_notas[i].id == notaId) {
        _notas[i].valor = novoValor;
        break;
      }
    }
  }

  static List<Nota> listarPorInscricao(int inscricaoId) {
    List<Nota> resultado = [];
    for (int i = 0; i < _notas.length; i++) {
      if (_notas[i].inscricaoId == inscricaoId) {
        resultado.add(_notas[i]);
      }
    }
    return resultado;
  }

  static List<Nota> listarPorDisciplina(int disciplinaId) {
    List<Inscricao> inscricoes = InscricaoOperacoes.listarPorDisciplina(disciplinaId);
    List<int> inscricaoIds = [];
    for (int i = 0; i < inscricoes.length; i++) {
      inscricaoIds.add(inscricoes[i].id!);
    }
    List<Nota> resultado = [];
    for (int i = 0; i < _notas.length; i++) {
      if (inscricaoIds.contains(_notas[i].inscricaoId)) {
        resultado.add(_notas[i]);
      }
    }
    return resultado;
  }

  static double calcularMediaPorDisciplina(int disciplinaId) {
    List<Nota> notas = listarPorDisciplina(disciplinaId);
    if (notas.isEmpty) {
      return 0.0;
    }
      double soma = 0.0;
      for (int i = 0; i < notas.length; i++) {
        soma += notas[i].valor;
      }
      return soma / notas.length;
    }
  }

