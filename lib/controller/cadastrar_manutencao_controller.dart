import 'package:flutter/material.dart';
import 'package:p1/controller/base_veiculo_controller.dart';
import 'package:p1/model/manutencao.dart';

class CadastrarManutencaoController extends BaseVeiculoController {
  final kmController = TextEditingController();
  final valorController = TextEditingController();
  final dataController = TextEditingController();

  Servico servico = Servico.oleoMotor;

  String? erroVeiculo;
  String? erroKm;
  String? erroValor;
  String? erroData;
  bool salvando = false;

  bool get temErro => [erroVeiculo, erroKm, erroValor, erroData]
      .any((erro) => erro != null);

  void selecionarServico(Servico novo) {
    servico = novo;
    notifyListeners();
  }

  DateTime? _lerData(String texto) {
    final partes = texto.split('/');
    if (partes.length != 3 || partes[2].length != 4) return null;

    final dia = int.tryParse(partes[0]);
    final mes = int.tryParse(partes[1]);
    final ano = int.tryParse(partes[2]);
    if (dia == null || mes == null || ano == null) return null;

    final data = DateTime(ano, mes, dia);

    if (data.day != dia || data.month != mes || data.year != ano) return null;

    return data;
  }

  Future<bool> salvar() async {
    final veiculo = veiculoSelecionado;
    final textoKm = kmController.text.trim();
    final textoValor = valorController.text.trim();
    final textoData = dataController.text.trim();

    erroVeiculo = null;
    erroKm = null;
    erroValor = null;
    erroData = null;

    if (veiculo == null) {
      erroVeiculo = 'Cadastre um veículo antes de registrar uma manutenção.';
    }

    final km = int.tryParse(textoKm);
    if (textoKm.isEmpty) {
      erroKm = 'Informe a quilometragem.';
    } else if (km == null) {
      erroKm = 'Quilometragem inválida.';
    }

    double? valor;
    if (textoValor.isNotEmpty) {
      valor = double.tryParse(textoValor.replaceAll(',', '.'));
      if (valor == null || valor < 0) {
        erroValor = 'Valor inválido.';
      }
    }

    final data = _lerData(textoData);
    if (textoData.isEmpty) {
      erroData = 'Informe a data.';
    } else if (data == null) {
      erroData = 'Data inválida.';
    } else if (data.isAfter(DateTime.now())) {
      erroData = 'A data não pode ser futura.';
    }

    if (temErro) {
      notifyListeners();
      return false;
    }

    salvando = true;
    notifyListeners();

    try {
      await service.cadastrarManutencao(
        veiculo!.id,
        Manutencao(
          id: '',
          servico: servico,
          km: km!,
          valor: valor,
          data: data!,
        ),
      );
      return true;
    } catch (_) {
      erroKm = 'Não foi possível salvar. Tente novamente.';
      return false;
    } finally {
      salvando = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    kmController.dispose();
    valorController.dispose();
    dataController.dispose();
    super.dispose();
  }
}
