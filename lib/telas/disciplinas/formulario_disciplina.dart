import 'package:flutter/material.dart';
import '../../modelos/disciplina.dart';

class FormularioDisciplina extends StatefulWidget {
  final Disciplina? disciplina;
  final Function(Disciplina) onGuardar;

  const FormularioDisciplina({
    super.key,
    this.disciplina,
    required this.onGuardar,
  });

  @override
  State<FormularioDisciplina> createState() => _FormularioDisciplinaState();
}

class _FormularioDisciplinaState extends State<FormularioDisciplina> {
  final TextEditingController _nomeController         = TextEditingController();
  final TextEditingController _cargaHorariaController = TextEditingController();
  final TextEditingController _descricaoController    = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.disciplina != null) {
      _nomeController.text         = widget.disciplina!.nome;
      _cargaHorariaController.text = widget.disciplina!.cargaHoraria.toString();
      _descricaoController.text    = widget.disciplina!.descricao;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cargaHorariaController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _guardar() {
    int cargaHoraria = int.tryParse(_cargaHorariaController.text) ?? 0;

    if (widget.disciplina != null) {
      widget.disciplina!.nome         = _nomeController.text;
      widget.disciplina!.cargaHoraria = cargaHoraria;
      widget.disciplina!.descricao    = _descricaoController.text;
      widget.onGuardar(widget.disciplina!);
    } else {
      Disciplina d = Disciplina(
        _nomeController.text,
        cargaHoraria,
        _descricaoController.text,
      );
      widget.onGuardar(d);
    }
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
            widget.disciplina == null ? 'Nova Disciplina' : 'Editar Disciplina',
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
              labelText: 'Nome',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _cargaHorariaController,
            decoration: const InputDecoration(
              labelText: 'Carga Horária (horas)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descricaoController,
            decoration: const InputDecoration(
              labelText: 'Descrição',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
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
