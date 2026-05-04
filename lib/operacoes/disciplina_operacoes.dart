import '../modelos/disciplina.dart';

class DisciplinaOperacoes {
  static List<Disciplina> _disciplinas = [];

  static void adicionar(Disciplina d) {
    _disciplinas.add(d);
  }

  static void editar(Disciplina d) {
    for (int i = 0; i < _disciplinas.length; i++) {
      if (_disciplinas[i].id == d.id) {
        _disciplinas[i] = d;
        break;
      }
    }
  }

  static void remover(int id) {
    for (int i = 0; i < _disciplinas.length; i++) {
      if (_disciplinas[i].id == id) {
        _disciplinas.removeAt(i);
        break;
      }
    }
  }

  static List<Disciplina> listarTodos() {
    return _disciplinas;
  }

  static Disciplina? buscarPorId(int id) {
    for (int i = 0; i < _disciplinas.length; i++) {
      if (_disciplinas[i].id == id) return _disciplinas[i];
    }
    return null;
  }
}
