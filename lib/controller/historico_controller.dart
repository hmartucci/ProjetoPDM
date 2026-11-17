import 'package:p1/controller/base_veiculo_controller.dart';
import 'package:p1/model/manutencao.dart';

class HistoricoController extends BaseVeiculoController {
  List<Manutencao> manutencoes = [];

  @override
  Future<void> carregarDetalhes() async {
    final veiculo = veiculoSelecionado;

    manutencoes =
        veiculo == null ? [] : await service.listarManutencoes(veiculo.id);
  }
}
