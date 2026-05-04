class Nota {
  final int? _id;
  final int _inscricaoId;
  final int _avaliacaoId;
  double _valor;
  String _observacao;

  Nota(this._inscricaoId, this._avaliacaoId, this._valor, this._observacao)
      : _id = null;

  int? get id => _id;

  int get inscricaoId => _inscricaoId;

  int get avaliacaoId => _avaliacaoId;

  double get valor => _valor;

  set valor(double value){
    _valor = value;
  }

  String get observacao   => _observacao;

  set observacao(String value) {
    _observacao = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'id':          _id,
      'inscricaoId': _inscricaoId,
      'avaliacaoId': _avaliacaoId,
      'valor':       _valor,
      'observacao':  _observacao,
    };
  }

  Nota.fromMap(Map<String, dynamic> map)
      : _id          = map['id'],
        _inscricaoId  = map['inscricaoId'],
        _avaliacaoId  = map['avaliacaoId'],
        _valor        = (map['valor'] as num).toDouble(),
        _observacao   = map['observacao'];

  @override
  String toString() {
    return 'Nota{_id: $_id, _inscricaoId: $_inscricaoId, _avaliacaoId: $_avaliacaoId, _valor: $_valor, _observacao: $_observacao}';
  }
}
