class Inscricao {
  final int? _id;
  final int _estudanteId;
  final int _disciplinaId;
  final String _dataInscricao;

  Inscricao(this._estudanteId, this._disciplinaId, this._dataInscricao)
      : _id = null;


  int? get id => _id;

  int get estudanteId => _estudanteId;

  int get disciplinaId => _disciplinaId;

  String get dataInscricao  => _dataInscricao;

  Inscricao.fromMap(Map<String, dynamic> map)
      : _id = map['id'],
        _estudanteId = map['estudanteId'],
        _disciplinaId = map['disciplinaId'],
        _dataInscricao = map['dataInscricao'];

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'estudanteId': _estudanteId,
      'disciplinaId': _disciplinaId,
      'dataInscricao': _dataInscricao,
    };
  }

  @override
  String toString() {
    return 'Inscricao{_id: $_id, _estudanteId: $_estudanteId, _disciplinaId: $_disciplinaId, _dataInscricao: $_dataInscricao}';
  }
}
