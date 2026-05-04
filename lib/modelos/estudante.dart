class Estudante {
  final int? _id;
  String _nome;
  String _email;
  String _curso;

  Estudante(this._nome, this._email, this._curso)
      : _id = null;


  int? get id => _id;

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get curso => _curso;

  set curso(String value) {
    _curso = value;
  }

   Estudante.fromMap(Map<String, dynamic> map)
       : _id = map['id'],
         _nome = map['nome'],
         _email = map['email'],
         _curso = map['curso'];

  Map<String, dynamic> toMap() {
    return {
      'id':_id,
      'nome':_nome,
      'email':_email,
      'curso':_curso,
    };
  }

  @override
  String toString() {
    return 'Estudante{_id: $_id, _nome: $_nome, _email: $_email, _curso: $_curso}';
  }
}
