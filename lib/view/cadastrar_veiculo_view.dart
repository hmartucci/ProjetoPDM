import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p1/controller/cadastrar_veiculo_controller.dart';

class CadastrarVeiculoView extends StatefulWidget {
  const CadastrarVeiculoView({super.key});

  @override
  State<CadastrarVeiculoView> createState() => _CadastrarVeiculoViewState();
}

class _CadastrarVeiculoViewState extends State<CadastrarVeiculoView> {
  final controller = CadastrarVeiculoController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Cadastrar Veículo'),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              return Column(
                children: [
                  TextField(
                    controller: controller.modeloController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Modelo',
                      errorText: controller.erroModelo,
                    ),
                  ),

                  SizedBox(height: 20),

                  TextField(
                    controller: controller.anoController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Ano',
                      errorText: controller.erroAno,
                    ),
                  ),

                  SizedBox(height: 20),

                  TextField(
                    controller: controller.placaController,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9-]')),
                      LengthLimitingTextInputFormatter(8),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Placa',
                      hintText: 'ABC1D23',
                      errorText: controller.erroPlaca,
                    ),
                  ),

                  SizedBox(height: 20),

                  TextField(
                    controller: controller.kmController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Quilometragem',
                      suffixText: 'km',
                      errorText: controller.erroKm,
                    ),
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: controller.carregando
                          ? null
                          : () async {
                              final sucesso = await controller.cadastrar();

                              if (!context.mounted) return;

                              if (sucesso) {
                                Navigator.pop(context);
                              }
                            },
                      child: controller.carregando
                          ? SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text('Cadastrar Veículo'),
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
