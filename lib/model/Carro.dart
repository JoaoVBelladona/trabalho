class Carro {
  String? id;
  String modelo;
  String ano;
  String placa;
  String nomeDono;
  String servico;
  String pronto;

  Carro({
    this.id,
    required this.modelo,
    required this.ano,
    required this.placa,
    required this.nomeDono,
    required this.servico,
    required this.pronto,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'modelo': modelo,
      'ano': ano,
      'placa': placa,
      'nomeDono': nomeDono,
      'servico': servico,
      'pronto': pronto,
    };
  }

  factory Carro.fromMap(Map<String, dynamic> map) {
    return Carro(
      id: map['id'],
      modelo: map['modelo'],
      ano: map['ano'],
      placa: map['placa'],
      nomeDono: map['nomeDono'],
      servico: map['servico'],
      pronto: map['pronto'],
    );
  }
}