
class Carro {
  final String? id;
  final String modelo;
  final String ano;
  final String placa;
  final String nomeDono;
  final String servico;
  final String pronto;


  Carro({
    this.id,
    required this.modelo,
    required this.ano,
    required this.placa,
    required this.nomeDono,
    required this.servico,
    required this.pronto,

  });

  factory Carro.fromMap(Map<String, dynamic> map) {
    return Carro(
      id: map['id']?.toString(),
      modelo: map['modelo']?.toString() ?? '',
      ano: map['ano']?.toString() ?? '',
      placa: map['placa']?.toString() ?? '',
      nomeDono: map['nomeDono']?.toString() ?? '',
      servico: map['servico']?.toString() ?? '',
      pronto: map['pronto']?.toString() ?? 'Não',
    );
  }
}
