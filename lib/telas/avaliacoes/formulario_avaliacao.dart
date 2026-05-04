import 'package:flutter/material.dart';
import '../../modelos/avaliacao.dart';

class FormularioAvaliacao extends StatefulWidget {
  final int disciplinaId;
  final Function(Avaliacao) onGuardar;

  const FormularioAvaliacao({
    super.key,
    required this.disciplinaId,
    required this.onGuardar,
  });

  @override
  State<FormularioAvaliacao> createState() => _FormularioAvaliacaoState();
}

class _FormularioAvaliacaoState extends State<FormularioAvaliacao> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _pesoController.dispose();
    super.dispose();
  }

  void _guardar() {
    double peso = double.tryParse(_pesoController.text) ?? 0.0;
    Avaliacao a = Avaliacao(
      widget.disciplinaId,
      _nomeController.text,
      peso,
    );
    widget.onGuardar(a);
  }

  @override
  Widget build(BuildContext context) {
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
            'Nova Avaliação',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome da Avaliação',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _pesoController,
            decoration: const InputDecoration(
              labelText: 'Peso (%)',
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
