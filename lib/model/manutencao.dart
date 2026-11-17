import 'package:cloud_firestore/cloud_firestore.dart';

enum Servico {
  oleoMotor('Óleo de Motor', 5000),
  filtroCombustivel('Filtro de Combustível', 10000),
  filtroAr('Filtro de Ar', 20000),
  pastilhasFreio('Pastilhas de Freio', 20000),
  pneus('Pneus', 40000);

  final String nome;
  final int intervaloKm;

  const Servico(this.nome, this.intervaloKm);
}

class Manutencao {
  final String id;
  final Servico servico;
  final int km;
  final double? valor;
  final DateTime data;

  const Manutencao({
    required this.id,
    required this.servico,
    required this.km,
    required this.valor,
    required this.data,
  });

  factory Manutencao.fromMap(String id, Map<String, dynamic> dados) {
    return Manutencao(
      id: id,
      servico: Servico.values.byName(dados['servico'] as String),
      km: (dados['km'] as num).toInt(),
      valor: (dados['valor'] as num?)?.toDouble(),
      data: (dados['data'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'servico': servico.name,
      'km': km,
      'valor': valor,
      'data': Timestamp.fromDate(data),
    };
  }
}
