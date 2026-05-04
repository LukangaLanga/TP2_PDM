import 'package:flutter/material.dart';
import '../../modelos/nota.dart';
import '../../modelos/inscricao.dart';
import '../../modelos/avaliacao.dart';
import '../../modelos/estudante.dart';

class FormularioNota extends StatefulWidget {
  final Nota?           nota;
  final List<Inscricao> inscricoes;
  final List<Avaliacao> avaliacoes;
  final List<Estudante> estudantes;
  final Function(Nota)  onGuardar;

  const FormularioNota({
    super.key,
    this.nota,
    required this.inscricoes,
    required this.avaliacoes,
    required this.estudantes,
    required this.onGuardar,
  });

  @override
  State<FormularioNota> createState() => _FormularioNotaState();
}

class _FormularioNotaState extends State<FormularioNota> {
  final TextEditingController _valorController = TextEditingController();
  Inscricao? _inscricaoSelecionada;
  Avaliacao? _avaliacaoSelecionada;

  @override
  void initState() {
    super.initState();
    if (widget.nota != null) {
      _valorController.text = widget.nota!.valor.toStringAsFixed(1);
    }
  }

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  String _nomeEstudante(Inscricao i) {
    final matches = widget.estudantes.where((e) => e.id == i.estudanteId);
    return matches.isEmpty ? 'Desconhecido' : matches.first.nome;
  }

  void _guardar() {
    double valor = double.tryParse(_valorController.text) ?? 0.0;

    if (widget.nota != null) {
      widget.nota!.valor = valor;
      widget.onGuardar(widget.nota!);
    } else {
      if (_inscricaoSelecionada == null || _avaliacaoSelecionada == null) return;
      Nota n = Nota(
        _inscricaoSelecionada!.id!,
        _avaliacaoSelecionada!.id!,
        valor,
        '',
      );
      widget.onGuardar(n);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool editando = widget.nota != null;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            editando ? 'Editar Nota' : 'Atribuir Nota',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          const SizedBox(height: 16),
          if (!editando) ...[
            DropdownButtonFormField<Inscricao>(
              value: _inscricaoSelecionada,
              decoration: const InputDecoration(
                labelText: 'Estudante',
                border: OutlineInputBorder(),
              ),
              items: widget.inscricoes.map((i) {
                return DropdownMenuItem(
                  value: i,
                  child: Text(_nomeEstudante(i)),
                );
              }).toList(),
              onChanged: (i) => setState(() => _inscricaoSelecionada = i),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<Avaliacao>(
              value: _avaliacaoSelecionada,
              decoration: const InputDecoration(
                labelText: 'Avaliação',
                border: OutlineInputBorder(),
              ),
              items: widget.avaliacoes.map((a) {
                return DropdownMenuItem(value: a, child: Text(a.nome));
              }).toList(),
              onChanged: (a) => setState(() => _avaliacaoSelecionada = a),
            ),
            const SizedBox(height: 12),
          ],
          TextField(
            controller: _valorController,
            decoration: const InputDecoration(
              labelText: 'Valor',
              border: OutlineInputBorder(),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: _guardar,
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
