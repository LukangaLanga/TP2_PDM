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

  // mensagens de erro por campo
  String? _erroNome;
  String? _erroCargaHoraria;
  String? _erroDescricao;

  @override
  void initState() {
    super.initState();
    // preenche os campos se estiver a editar
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

  // valida os campos e guarda a disciplina
  void _guardar() {
    String nome      = _nomeController.text.trim();
    String cargaStr  = _cargaHorariaController.text.trim();
    String descricao = _descricaoController.text.trim();
    int?   carga     = int.tryParse(cargaStr);

    setState(() {
      _erroNome        = nome.isEmpty      ? 'O nome não pode estar vazio'            : null;
      _erroCargaHoraria = cargaStr.isEmpty ? 'A carga horária não pode estar vazia'  :
                          (carga == null || carga <= 0) ? 'Insira um número válido maior que 0' : null;
      _erroDescricao   = descricao.isEmpty ? 'A descrição não pode estar vazia'       : null;
    });

    if (nome.isEmpty || descricao.isEmpty || carga == null || carga <= 0) return;

    if (widget.disciplina != null) {
      widget.disciplina!.nome         = nome;
      widget.disciplina!.cargaHoraria = carga;
      widget.disciplina!.descricao    = descricao;
      widget.onGuardar(widget.disciplina!);
    } else {
      widget.onGuardar(Disciplina(nome, carga, descricao));
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
            decoration: InputDecoration(
              labelText: 'Nome',
              border: const OutlineInputBorder(),
              errorText: _erroNome,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _cargaHorariaController,
            decoration: InputDecoration(
              labelText: 'Carga Horária (horas)',
              border: const OutlineInputBorder(),
              errorText: _erroCargaHoraria,
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descricaoController,
            decoration: InputDecoration(
              labelText: 'Descrição',
              border: const OutlineInputBorder(),
              errorText: _erroDescricao,
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
