
String _milhar(String digitos) => digitos.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => '.',
    );

String formatarKm(int km) => _milhar(km.toString());

String formatarValor(double valor) {
  final partes = valor.toStringAsFixed(2).split('.');
  return 'R\$ ${_milhar(partes[0])},${partes[1]}';
}

String formatarData(DateTime data) {
  final dia = data.day.toString().padLeft(2, '0');
  final mes = data.month.toString().padLeft(2, '0');
  return '$dia/$mes/${data.year}';
}
