import 'package:flutter/material.dart';
import 'package:trabalhodisp/model/Carro.dart';
import 'package:trabalhodisp/services/CarroService.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

  final List<Carro> carros = [];
  final modeloController = TextEditingController();
  final anoController = TextEditingController();
  final placaController = TextEditingController();
  final nomeController = TextEditingController();
  final servicoController = TextEditingController();

class _PrincipalPageState extends State<PrincipalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Serviço de Oficina'),
      ),
      body: const Center(
        child:  Column(
  
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Text('Aqui você pode gerenciar seus serviços e clientes.'),
          ],
        ),










      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Adicionar Serviços'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: modeloController,
                      decoration: const InputDecoration(labelText: 'Modelo do veículo'),

                    ),
                    TextField(
                      controller: anoController,
                      decoration: const InputDecoration(labelText: 'Ano do veículo'),
                    ),
                    TextField(
                      controller: placaController,
                      decoration: const InputDecoration(labelText: 'Placa do veículo'),
                    ),
                    TextField(
                      controller: nomeController,
                      decoration: const InputDecoration(labelText: 'Nome do dono'),
                    ),
                    TextField(
                      controller: servicoController,
                      decoration: const InputDecoration(labelText: 'Serviço'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final carro = Carro(
                        modelo: modeloController.text,
                        ano: anoController.text,
                        placa: placaController.text,
                        nomeDono: nomeController.text,
                        servico: servicoController.text, 
                        pronto: 'Não',
                      );
                      try {
                        CarroService.salvaCarro(carro);
                        print('Carro salvo com sucesso!');
                      } catch (e) {
                        print('Erro ao salvar o carro: $e');
                      }
                    },

                    child: const Text('Salvar'),
                  ),
                ],
              );
            },
          );
        },


        child: Icon(Icons.add),
            ),

    );
  }
}