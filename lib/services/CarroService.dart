import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trabalhodisp/model/Carro.dart';

class CarroService {




  static Future<void> salvaCarro(Carro carro) async {
        await FirebaseFirestore.instance.collection('Servicos').add({
        'modelo': carro.modelo,
        'ano': carro.ano,
        'placa': carro.placa,
        'nomeDono': carro.nomeDono,
        'servico': carro.servico,
        'pronto': carro.pronto,
      }); }
}