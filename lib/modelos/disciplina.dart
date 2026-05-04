class Disciplina {
  final int? _id;
  String _nome;
  int _cargaHoraria;
  String _descricao;

  Disciplina(this._nome, this._cargaHoraria, this._descricao)
      : _id = null;

  int? get id => _id;

  String get nome => _nome;

  set nome(String nome){
    _nome = nome;
  }

  int get cargaHoraria  => _cargaHoraria;

  set cargaHoraria(int cargaHoraria){
    _cargaHoraria  = cargaHoraria;
  }

  String get descricao => _descricao;

  set descricao(String descricao){
    _descricao = descricao;
  }

  Map<String, dynamic> toMap() {
    return {
      'id':_id,
      'nome':_nome,
      'cargaHoraria':_cargaHoraria,
      'descricao':_descricao,
    };
  }

  Disciplina.fromMap(Map<String, dynamic> map)
      : _id = map['id'],
        _nome= map['nome'],
        _cargaHoraria = map['cargaHoraria'],
        _descricao= map['descricao'];

  @override
  String toString() {
    return 'Disciplina{_codigo: $_id, _nome: $_nome, _cargaHoraria: $_cargaHoraria, _descricao: $_descricao}';
  }
}
