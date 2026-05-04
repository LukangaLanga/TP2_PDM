import '../modelos/inscricao.dart';

class InscricaoOperacoes {
  static List<Inscricao> _inscricoes = [];

  static void inscrever(int estudanteId, int disciplinaId) {
    if (estudanteJaInscrito(estudanteId, disciplinaId)) {
      return;
    }
    Inscricao i = Inscricao(estudanteId, disciplinaId, DateTime.now().toString());
    _inscricoes.add(i);
    }


  static bool estudanteJaInscrito(int estudanteId, int disciplinaId) {
    for (int i = 0; i < _inscricoes.length; i++) {
      if (_inscricoes[i].estudanteId == estudanteId && _inscricoes[i].disciplinaId == disciplinaId) {
        return true;
      }
    }
    return false;
  }

  static void remover(int id) {
    for (int i = 0; i < _inscricoes.length; i++) {
      if (_inscricoes[i].id == id) {
        _inscricoes.removeAt(i);
        break;
      }
    }
  }

  static List<Inscricao> listarPorEstudante(int estudanteId) {
    List<Inscricao> resultado = [];
    for (int i = 0; i < _inscricoes.length; i++) {
      if (_inscricoes[i].estudanteId == estudanteId) {
        resultado.add(_inscricoes[i]);
      }
    }
    return resultado;
  }

  static List<Inscricao> listarPorDisciplina(int disciplinaId) {
    List<Inscricao> resultado = [];
    for (int i = 0; i < _inscricoes.length; i++) {
      if (_inscricoes[i].disciplinaId == disciplinaId) {
        resultado.add(_inscricoes[i]);
      }
    }
    return resultado;
  }
}
