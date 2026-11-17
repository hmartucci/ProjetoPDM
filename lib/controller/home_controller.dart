import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:p1/controller/base_veiculo_controller.dart';
import 'package:p1/core/formatadores.dart';
import 'package:p1/model/status_servico.dart';

class HomeController extends BaseVeiculoController {
  String nomeUsuario = '';

  List<StatusServico> proximas = [];

  Future<void> carregarNome() async {
    try {
      final usuario = FirebaseAuth.instance.currentUser;
      if (usuario == null) return;

      final doc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuario.uid)
          .get();

      nomeUsuario = (doc.data()?['nome'] as String?) ?? '';
    } catch (_) {
      nomeUsuario = '';
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<void> carregarDetalhes() async {
    final veiculo = veiculoSelecionado;

    if (veiculo == null) {
      proximas = [];
      return;
    }

    final manutencoes = await service.listarManutencoes(veiculo.id);
    final todos = StatusServico.calcular(veiculo, manutencoes);

    todos.sort((a, b) => a.proximoKm.compareTo(b.proximoKm));
    proximas = todos.take(3).toList();
  }

  Future<String?> atualizarKm(String texto) async {
    final veiculo = veiculoSelecionado;
    if (veiculo == null) return 'Nenhum veículo selecionado.';

    final novoKm = int.tryParse(texto.trim());
    if (novoKm == null) return 'Informe a quilometragem.';

    if (novoKm < veiculo.km) {
      return 'A quilometragem não pode ser menor que a já cadastrada '
          '(${formatarKm(veiculo.km)} km).';
    }

    try {
      await service.atualizarKm(veiculo.id, novoKm);
      await carregar();
      return null;
    } catch (_) {
      return 'Não foi possível salvar. Tente novamente.';
    }
  }
}
