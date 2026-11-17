import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p1/controller/cadastrar_manutencao_controller.dart';
import 'package:p1/model/manutencao.dart';
import 'package:p1/view/widgets/seletor_veiculo.dart';

class CadastrarManutencaoView extends StatefulWidget {
  const CadastrarManutencaoView({super.key});

  @override
  State<CadastrarManutencaoView> createState() => _CadastrarManutencaoViewState();
}

class _CadastrarManutencaoViewState extends State<CadastrarManutencaoView> {
  final controller = CadastrarManutencaoController();

  @override
  void initState() {
    super.initState();
    controller.carregar();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Cadastrar Manutenção'),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              return Column(
                children: [

                  SeletorVeiculo(
                    veiculos: controller.veiculos,
                    selecionadoId: controller.veiculoSelecionadoId,
                    onChanged: controller.selecionarVeiculo,
                  ),

                  if (controller.erroVeiculo != null)
                    Text(
                      controller.erroVeiculo!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),

                  SizedBox(height: 20),

                  DropdownButton<Servico>(
                    value: controller.servico,
                    items: Servico.values
                        .map((s) => DropdownMenuItem(
                              value: s,
                              child: Text(s.nome),
                            ))
                        .toList(),
                    onChanged: (novo) {
                      if (novo != null) controller.selecionarServico(novo);
                    },
                  ),

                  SizedBox(height: 20),

                  TextField(
                    controller: controller.kmController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Quilometragem da Manutenção',
                      suffixText: 'km',
                      errorText: controller.erroKm,
                    ),
                  ),

                  SizedBox(height: 20),

                  TextField(
                    controller: controller.valorController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Valor (opcional)',
                      prefixText: 'R\$ ',
                      errorText: controller.erroValor,
                    ),
                  ),

                  SizedBox(height: 20),

                  TextField(
                    controller: controller.dataController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      DataInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Data da Manutenção',
                      hintText: 'dd/mm/aaaa',
                      errorText: controller.erroData,
                    ),
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: controller.salvando
                          ? null
                          : () async {
                              final sucesso = await controller.salvar();

                              if (!context.mounted) return;

                              if (sucesso) {
                                Navigator.pop(context);
                              }
                            },
                      child: controller.salvando
                          ? SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text('Cadastrar Manutenção'),
                    ),

                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
