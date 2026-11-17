class Veiculo {
  final String id;
  final String modelo;
  final int ano;
  final String placa;
  final int km;
  final int kmInicial;

  const Veiculo({
    required this.id,
    required this.modelo,
    required this.ano,
    required this.placa,
    required this.km,
    required this.kmInicial,
  });

  String get descricao => '$modelo $ano';

  factory Veiculo.fromMap(String id, Map<String, dynamic> dados) {
    final km = (dados['km'] as num).toInt();
    return Veiculo(
      id: id,
      modelo: dados['modelo'] as String,
      ano: (dados['ano'] as num).toInt(),
      placa: dados['placa'] as String,
      km: km,
      kmInicial: (dados['kmInicial'] as num?)?.toInt() ?? km,
    );
  }
}
