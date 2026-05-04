class Avaliacao {
  final int? _id;
  final int _disciplinaId;
  String _nome;
  double _peso;

  Avaliacao(this._disciplinaId, this._nome, this._peso)
      : _id = null;

  int? get id => _id;

  int get disciplinaId => _disciplinaId;

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  double get peso => _peso;

  set peso(double value) {
    _peso = value;
  }

  Avaliacao.fromMap(Map<String, dynamic> map)
      : _id = map['id'],
        _disciplinaId = map['disciplinaId'],
        _nome= map['nome'],
        _peso= (map['peso'] as num).toDouble();


  Map<String, dynamic> toMap() {
    return {
      'id':_id,
      'disciplinaId':_disciplinaId,
      'nome':_nome,
      'peso':_peso,
    };
  }

  @override
  String toString() {
    return 'Avaliacao{_id: $_id, _disciplinaId: $_disciplinaId, _nome: $_nome, _peso: $_peso}';
  }
}
