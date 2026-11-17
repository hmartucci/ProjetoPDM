import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:p1/model/manutencao.dart';
import 'package:p1/model/veiculo.dart';

class VeiculoService {
  CollectionReference<Map<String, dynamic>> get _veiculos {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid)
        .collection('veiculos');
  }

  Future<List<Veiculo>> listarVeiculos() async {
    final consulta = await _veiculos.orderBy('criadoEm').get();
    return consulta.docs
        .map((doc) => Veiculo.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<void> cadastrarVeiculo({
    required String modelo,
    required int ano,
    required String placa,
    required int km,
  }) async {
    await _veiculos.add({
      'modelo': modelo,
      'ano': ano,
      'placa': placa,
      'km': km,
      'kmInicial': km,
      'criadoEm': FieldValue.serverTimestamp(),
    });
  }

  Future<void> atualizarKm(String veiculoId, int km) async {
    await _veiculos.doc(veiculoId).update({'km': km});
  }

  Future<List<Manutencao>> listarManutencoes(String veiculoId) async {
    final consulta = await _veiculos
        .doc(veiculoId)
        .collection('manutencoes')
        .orderBy('data', descending: true)
        .get();

    return consulta.docs
        .map((doc) => Manutencao.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<void> cadastrarManutencao(
    String veiculoId,
    Manutencao manutencao,
  ) async {
    await _veiculos
        .doc(veiculoId)
        .collection('manutencoes')
        .add(manutencao.toMap());
  }
}
