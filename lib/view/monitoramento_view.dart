import 'package:flutter/material.dart';
import 'package:p1/controller/monitoramento_controller.dart';
import 'package:p1/core/formatadores.dart';
import 'package:p1/model/status_servico.dart';
import 'package:p1/view/widgets/seletor_veiculo.dart';

class MonitoramentoView extends StatefulWidget {
  const MonitoramentoView({super.key});

  @override
  State<MonitoramentoView> createState() => _MonitoramentoViewState();
}

class _MonitoramentoViewState extends State<MonitoramentoView> {
  final controller = MonitoramentoController();

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

  Color _cor(int percentual) {
    if (percentual >= 50) return Colors.green.shade100;
    if (percentual >= 20) return Colors.yellow.shade100;
    return Colors.red.shade200;
  }

  Widget _mensagem(String texto) {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Center(child: Text(texto, textAlign: TextAlign.center)),
    );
  }

  Widget _card(StatusServico s) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Card(
        color: _cor(s.percentual),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),

        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(s.servico.nome),
              Text('${s.percentual}%'),
            ],
          ),
          subtitle: Text('Próxima troca em ${formatarKm(s.kmRestantes)} km'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text('Monitoramento'),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, _) {
            final veiculo = controller.veiculoSelecionado;

            return ListView(
              children: [
                
                Align(
                  alignment: Alignment.centerLeft,
                  child: SeletorVeiculo(
                    veiculos: controller.veiculos,
                    selecionadoId: controller.veiculoSelecionadoId,
                    onChanged: controller.selecionarVeiculo,
                  ),
                ),

                if (veiculo != null)
                  Text(
                    'Quilometragem atual: ${formatarKm(veiculo.km)} km',
                    style: TextStyle(fontSize: 16),
                  ),

                SizedBox(height: 20),

                if (controller.carregando)
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (controller.erro != null)
                  _mensagem(controller.erro!)
                else if (veiculo == null)
                  _mensagem('Nenhum veículo cadastrado.')
                else
                  ...controller.status.map(_card),

              ],
            );
          },
        ),
      ),
    );
  }
}
