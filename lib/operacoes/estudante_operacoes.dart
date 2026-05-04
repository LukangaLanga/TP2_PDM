import '../modelos/estudante.dart';

class EstudanteOperacoes {
  static List<Estudante> _estudantes = [];

  static void adicionar(Estudante e) {
    _estudantes.add(e);
  }

  static void editar(Estudante e) {
    for (int i = 0; i < _estudantes.length; i++) {
      if (_estudantes[i].id == e.id) {
        _estudantes[i] = e;
        break;
      }
    }
  }

  static void remover(int id) {
    for (int i = 0; i < _estudantes.length; i++) {
      if (_estudantes[i].id == id) {
        _estudantes.removeAt(i);
        break;
      }
    }
  }

  static List<Estudante> listarTodos() {
    return _estudantes;
  }

  static Estudante? buscarPorId(int id) {
    for (int i = 0; i < _estudantes.length; i++) {
      if (_estudantes[i].id == id) return _estudantes[i];
    }
    return null;
  }
}
