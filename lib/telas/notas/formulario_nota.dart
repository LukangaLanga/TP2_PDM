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
      // pré-seleciona a avaliação para saber o peso máximo
      final matches = widget.avaliacoes.where((a) => a.id == widget.nota!.avaliacaoId);
      if (matches.isNotEmpty) _avaliacaoSelecionada = matches.first;
    }
  }

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  // devolve o nome do estudante a partir da inscrição
  String _nomeEstudante(Inscricao i) {
    final matches = widget.estudantes.where((e) => e.id == i.estudanteId);
    return matches.isEmpty ? 'Desconhecido' : matches.first.nome;
  }

  // mostra uma mensagem de erro com AlertDialog simples
  void _mostrarErro(String mensagem) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Erro'),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // valida e guarda a nota
  void _guardar() {
    bool editando = widget.nota != null;

    // valida os dropdowns quando estiver a criar uma nova nota
    if (!editando) {
      if (_inscricaoSelecionada == null) {
        _mostrarErro('Selecione um estudante');
        return;
      }
      if (_avaliacaoSelecionada == null) {
        _mostrarErro('Selecione uma avaliação');
        return;
      }
    }

    // validação do valor da nota
    String texto = _valorController.text.trim();
    if (texto.isEmpty) {
      _mostrarErro('O campo não pode estar vazio');
      return;
    }
    double? valor = double.tryParse(texto);
    if (valor == null) {
      _mostrarErro('Valor inválido');
      return;
    }
    if (valor < 0) {
      _mostrarErro('A nota não pode ser negativa');
      return;
    }
    final peso = _avaliacaoSelecionada?.peso;
    if (peso != null && valor > peso) {
      _mostrarErro('A nota não pode ser superior ao peso (${peso.toStringAsFixed(1)})');
      return;
    }

    if (editando) {
      widget.nota!.valor = valor;
      widget.onGuardar(widget.nota!);
    } else {
      widget.onGuardar(Nota(
        _inscricaoSelecionada!.id!,
        _avaliacaoSelecionada!.id!,
        valor,
        '',
      ));
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
          // dropdowns só aparecem quando criar uma nova nota
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
                return DropdownMenuItem(
                  value: a,
                  child: Text('${a.nome} (peso: ${a.peso.toStringAsFixed(1)})'),
                );
              }).toList(),
              onChanged: (a) => setState(() => _avaliacaoSelecionada = a),
            ),
            const SizedBox(height: 12),
          ],
          // mostra o peso máximo quando a avaliação está seleccionada
          if (_avaliacaoSelecionada != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Peso máximo: ${_avaliacaoSelecionada!.peso.toStringAsFixed(1)}',
                style: TextStyle(color: Colors.grey[700], fontSize: 13),
              ),
            ),
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
