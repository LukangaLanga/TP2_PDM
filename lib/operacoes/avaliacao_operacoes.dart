import '../modelos/avaliacao.dart';

class AvaliacaoOperacoes {
  static List<Avaliacao> _avaliacoes = [];

  static void adicionar(Avaliacao a) {

    for (int i = 0; i < _avaliacoes.length; i++) {
      if(_avaliacoes[i].nome.toLowerCase() == a.nome.toLowerCase()){
        print('A avaliacao ja existe');
        return;
      }
    }
    _avaliacoes.add(a);
  }

  static void remover(int id) {
    for (int i = 0; i < _avaliacoes.length; i++) {
      if (_avaliacoes[i].id == id) {
        _avaliacoes.removeAt(i);
        break;
      }
    }
  }

  static List<Avaliacao> listarPorDisciplina(int disciplinaId) {
    List<Avaliacao> resultado = [];
    for (int i = 0; i < _avaliacoes.length; i++) {
      if (_avaliacoes[i].disciplinaId == disciplinaId) {
        resultado.add(_avaliacoes[i]);
      }
    }
    return resultado;
  }
}
