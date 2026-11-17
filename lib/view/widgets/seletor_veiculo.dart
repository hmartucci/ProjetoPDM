import 'package:flutter/material.dart';
import 'package:p1/model/veiculo.dart';

class SeletorVeiculo extends StatelessWidget {
  final List<Veiculo> veiculos;
  final String? selecionadoId;
  final ValueChanged<String> onChanged;
  final TextStyle? style;

  const SeletorVeiculo({
    super.key,
    required this.veiculos,
    required this.selecionadoId,
    required this.onChanged,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      style: style,
      value: selecionadoId,
      hint: const Text('Nenhum veículo cadastrado'),
      items: veiculos
          .map((v) => DropdownMenuItem(value: v.id, child: Text(v.descricao)))
          .toList(),
      onChanged: veiculos.isEmpty
          ? null
          : (id) {
              if (id != null) onChanged(id);
            },
    );
  }
}
