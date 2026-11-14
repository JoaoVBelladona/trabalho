
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trabalhodisp/model/carro.dart';

class CarroService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;


  static Stream<List<Carro>> getCarros() {
    return _firestore
        .collection('Servicos')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Carro.fromMap({
          ...doc.data(),
          'id': doc.id,
        });
      }).toList();
    });
  }


  static Future<void> salvaCarro(Carro carro, String idUsuario) async {
    await _firestore.collection('Servicos').add({
      'modelo': carro.modelo,
      'ano': carro.ano,
      'placa': carro.placa,
      'nomeDono': carro.nomeDono,
      'servico': carro.servico,
      'pronto': carro.pronto,
      'idUsuario': carro.idUsuario
    });
  }

  static Future<void> deletarCarro(String id) async {
    await _firestore.collection('Servicos').doc(id).delete();
  }

  static Future<void> alterarCarro(
    String id,
    Carro carro,
  ) async {
    if (id.isEmpty) {
      throw Exception('ID do carro não informado.');
    }

    await _firestore
        .collection('Servicos')
        .doc(id)
        .update({
      'modelo': carro.modelo,
      'ano': carro.ano,
      'placa': carro.placa,
      'nomeDono': carro.nomeDono,
      'servico': carro.servico,
      'pronto': carro.pronto,
      'idUsuario': carro.idUsuario
    });
  }
}
