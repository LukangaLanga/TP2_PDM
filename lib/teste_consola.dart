import 'modelos/estudante.dart';
import 'modelos/disciplina.dart';
import 'modelos/avaliacao.dart';
import 'modelos/inscricao.dart';
import 'modelos/nota.dart';
import 'base_dados/locator.dart';

testarTudo() async {

  print("Estudantes:");
  List<Estudante> estudantes = await Locator.estudante.listarTodos();
  for (Estudante e in estudantes) {
    print(e);
  }
  print("");
  print("Disciplinas: ");
  List<Disciplina> disciplinas = await Locator.disciplina.listarTodos();
  for (Disciplina d in disciplinas) {
    print(d);
  }


  print("");
  print("Avaliações: ");

  List<Avaliacao> a1 = await Locator.avaliacao.listarPorDisciplina(1);
  for(Avaliacao a in a1){
    print(a);
  }
  List<Avaliacao> a2 = await Locator.avaliacao.listarPorDisciplina(2);
  for(Avaliacao a in a2){
    print(a);
  }

  print("");

  print ("Inscricoes: ");

  await Locator.inscricao.inscrever(3, 1);
  await Locator.inscricao.inscrever(1, 1);

  List<Inscricao> i1 =  await Locator.inscricao.listarPorDisciplina(1);
  for (Inscricao i in i1){
    print(i);
  }

  print("");
  print("Notas: ");
  await Locator.nota.atribuirNota(3, 6, 50);
  List<Nota> notas = await Locator.nota.listarPorDisciplina(1);
  for(Nota n in notas){
    print(n);
  }


}
