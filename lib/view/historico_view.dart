import 'package:flutter/material.dart';
import 'package:p1/controller/historico_controller.dart';
import 'package:p1/core/app_routes.dart';
import 'package:p1/core/formatadores.dart';
import 'package:p1/model/manutencao.dart';
import 'package:p1/view/widgets/seletor_veiculo.dart';

class HistoricoView extends StatefulWidget {
  const HistoricoView({super.key});

  @override
  State<HistoricoView> createState() => _HistoricoViewState();
}

class _HistoricoViewState extends State<HistoricoView> {
  final controller = HistoricoController();

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

  Widget _mensagem(String texto) {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Center(child: Text(texto, textAlign: TextAlign.center)),
    );
  }

  Widget _card(Manutencao m) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),

        child: ListTile(
          title: Text(m.servico.nome),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Data: ${formatarData(m.data)}'),
              Text('Quilometragem: ${formatarKm(m.km)} km'),
              Text(
                m.valor == null
                    ? 'Valor: não informado'
                    : 'Valor: ${formatarValor(m.valor!)}',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text('Histórico'),
      ),
      
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, _) {
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

                if (controller.carregando)
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (controller.erro != null)
                  _mensagem(controller.erro!)
                else if (controller.veiculos.isEmpty)
                  _mensagem('Nenhum veículo cadastrado.')
                else if (controller.manutencoes.isEmpty)
                  _mensagem('Nenhuma manutenção registrada para este veículo.')
                else
                  ...controller.manutencoes.map(_card),

              ],
            );
          },
        ),

      ),


      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.pushNamed(context, AppRoutes.cadastrarManutencao);
          if (!mounted) return;
          controller.carregar();
        },
        icon: Icon(Icons.add),
        label: Text('Nova manutenção'),
      ),
  
    );
  }
}
