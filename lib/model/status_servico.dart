import 'package:p1/model/manutencao.dart';
import 'package:p1/model/veiculo.dart';

class StatusServico {
  final Servico servico;
  final int kmBase;
  final int kmAtual;

  const StatusServico({
    required this.servico,
    required this.kmBase,
    required this.kmAtual,
  });

  int get proximoKm => kmBase + servico.intervaloKm;

  int get kmRestantes =>
      (proximoKm - kmAtual).clamp(0, servico.intervaloKm).toInt();

  int get percentual => (kmRestantes * 100 / servico.intervaloKm).round();

  static List<StatusServico> calcular(
    Veiculo veiculo,
    List<Manutencao> manutencoes,
  ) {
    return Servico.values.map((servico) {
      final kms =
          manutencoes.where((m) => m.servico == servico).map((m) => m.km);

      final kmBase = kms.isEmpty
          ? veiculo.kmInicial
          : kms.reduce((a, b) => a > b ? a : b);

      return StatusServico(
        servico: servico,
        kmBase: kmBase,
        kmAtual: veiculo.km,
      );
    }).toList();
  }
}
