import 'package:p1/controller/base_veiculo_controller.dart';
import 'package:p1/model/status_servico.dart';

class MonitoramentoController extends BaseVeiculoController {
  List<StatusServico> status = [];

  @override
  Future<void> carregarDetalhes() async {
    final veiculo = veiculoSelecionado;

    if (veiculo == null) {
      status = [];
      return;
    }

    final manutencoes = await service.listarManutencoes(veiculo.id);
    status = StatusServico.calcular(veiculo, manutencoes);
  }
}
