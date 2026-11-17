import 'package:flutter/material.dart';
import 'package:p1/model/veiculo.dart';
import 'package:p1/service/veiculo_service.dart';

class BaseVeiculoController extends ChangeNotifier {
  final service = VeiculoService();

  List<Veiculo> veiculos = [];

  static String? _selecionadoId;

  String? get veiculoSelecionadoId => _selecionadoId;
  set veiculoSelecionadoId(String? id) => _selecionadoId = id;

  bool carregando = false;
  String? erro;

  Veiculo? get veiculoSelecionado =>
      veiculos.where((v) => v.id == veiculoSelecionadoId).firstOrNull;

  Future<void> carregar() async {
    carregando = true;
    erro = null;
    notifyListeners();

    try {
      veiculos = await service.listarVeiculos();

      if (veiculoSelecionado == null) {
        veiculoSelecionadoId = veiculos.isEmpty ? null : veiculos.first.id;
      }

      await carregarDetalhes();
    } catch (_) {
      erro = 'Não foi possível carregar os dados.';
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  Future<void> selecionarVeiculo(String id) async {
    veiculoSelecionadoId = id;
    carregando = true;
    erro = null;
    notifyListeners();

    try {
      await carregarDetalhes();
    } catch (_) {
      erro = 'Não foi possível carregar os dados.';
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  Future<void> carregarDetalhes() async {}

  bool _descartado = false;

  @override
  void dispose() {
    _descartado = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_descartado) super.notifyListeners();
  }
}
