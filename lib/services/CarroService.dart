import 'package:cloud_firestore/cloud_firestore.dart';

class ContatoService {




  static Future<void> salvaCarro(String modelo, String ano, String placa, String nomeDono, String servico, String pronto) async {
        await FirebaseFirestore.instance.collection('Servicos').add({
        'modelo': modelo,
        'ano': ano,
        'placa': placa,
        'nomeDono': nomeDono,
        'servico': servico,
        'pronto': pronto = 'Não',
      }); }
}