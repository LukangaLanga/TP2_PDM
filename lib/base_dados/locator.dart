import '../base_dados/estudante_repositorio.dart';
import '../base_dados/disciplina_repositorio.dart';
import '../base_dados/avaliacao_repositorio.dart';
import '../base_dados/inscricao_repositorio.dart';
import '../base_dados/nota_repositorio.dart';

class Locator {
  static EstudanteRepositorio  estudante  = EstudanteRepositorio();
  static DisciplinaRepositorio disciplina = DisciplinaRepositorio();
  static AvaliacaoRepositorio  avaliacao  = AvaliacaoRepositorio();
  static InscricaoRepositorio  inscricao  = InscricaoRepositorio();
  static NotaRepositorio  nota = NotaRepositorio();
}
