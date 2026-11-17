import 'package:flutter/material.dart';
import 'package:p1/service/veiculo_service.dart';

class CadastrarVeiculoController extends ChangeNotifier {
  final _service = VeiculoService();

  final modeloController = TextEditingController();
  final anoController = TextEditingController();
  final placaController = TextEditingController();
  final kmController = TextEditingController();

  String? erroModelo;
  String? erroAno;
  String? erroPlaca;
  String? erroKm;
  bool carregando = false;

  bool get temErro => [erroModelo, erroAno, erroPlaca, erroKm]
      .any((erro) => erro != null);

  Future<bool> cadastrar() async {
    final modelo = modeloController.text.trim();
    final textoAno = anoController.text.trim();
    final placa = placaController.text
        .toUpperCase()
        .replaceAll(RegExp(r'[\s-]'), '');
    final textoKm = kmController.text.trim();

    erroModelo = null;
    erroAno = null;
    erroPlaca = null;
    erroKm = null;

    if (modelo.isEmpty) {
      erroModelo = 'Informe o modelo.';
    }

    final ano = int.tryParse(textoAno);
    if (textoAno.isEmpty) {
      erroAno = 'Informe o ano.';
    } else if (ano == null ||
        textoAno.length != 4 ||
        ano < 1900 ||
        ano > DateTime.now().year + 1) {
      erroAno = 'Ano inválido.';
    }

    if (placa.isEmpty) {
      erroPlaca = 'Informe a placa.';
    } else if (!RegExp(r'^[A-Z]{3}[0-9][A-Z0-9][0-9]{2}$').hasMatch(placa)) {
      erroPlaca = 'Placa inválida.';
    }

    final km = int.tryParse(textoKm);
    if (textoKm.isEmpty) {
      erroKm = 'Informe a quilometragem.';
    } else if (km == null) {
      erroKm = 'Quilometragem inválida.';
    }

    if (temErro) {
      notifyListeners();
      return false;
    }

    carregando = true;
    notifyListeners();

    try {
      await _service.cadastrarVeiculo(
        modelo: modelo,
        ano: ano!,
        placa: placa,
        km: km!,
      );
      return true;
    } catch (_) {
      erroModelo = 'Não foi possível salvar. Tente novamente.';
      return false;
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    modeloController.dispose();
    anoController.dispose();
    placaController.dispose();
    kmController.dispose();
    super.dispose();
  }
}
