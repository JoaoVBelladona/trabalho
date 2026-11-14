
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trabalhodisp/model/carro.dart';
import 'package:trabalhodisp/services/CarroService.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  final modeloController = TextEditingController();
  final anoController = TextEditingController();
  final placaController = TextEditingController();
  final nomeController = TextEditingController();
  final servicoController = TextEditingController();

  String prontoSelecionado = 'Não';

  @override
  void dispose() {
    modeloController.dispose();
    anoController.dispose();
    placaController.dispose();
    nomeController.dispose();
    servicoController.dispose();
    super.dispose();
  }

  void limparCampos() {
    modeloController.clear();
    anoController.clear();
    placaController.clear();
    nomeController.clear();
    servicoController.clear();
  }

  // CADASTRAR CARRO
  void abrirFormulario() {
    limparCampos();
    prontoSelecionado = 'Não';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, atualizarDialogo) {
            return AlertDialog(
              title: const Text('Adicionar Serviço'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: modeloController,
                      decoration: const InputDecoration(
                        labelText: 'Modelo do veículo',
                      ),
                    ),
                    TextField(
                      controller: anoController,
                      decoration: const InputDecoration(
                        labelText: 'Ano do veículo',
                      ),
                    ),
                    TextField(
                      controller: placaController,
                      decoration: const InputDecoration(
                        labelText: 'Placa do veículo',
                      ),
                    ),
                    TextField(
                      controller: nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do dono',
                      ),
                    ),
                    TextField(
                      controller: servicoController,
                      decoration: const InputDecoration(
                        labelText: 'Serviço',
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Status do serviço:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    RadioListTile<String>(
                      title: const Text('Pronto'),
                      value: 'Sim',
                      groupValue: prontoSelecionado,
                      onChanged: (value) {
                        atualizarDialogo(() {
                          prontoSelecionado = value!;
                        });
                      },
                    ),

                    RadioListTile<String>(
                      title: const Text('Não pronto'),
                      value: 'Não',
                      groupValue: prontoSelecionado,
                      onChanged: (value) {
                        atualizarDialogo(() {
                          prontoSelecionado = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final carro = Carro(
                      modelo: modeloController.text,
                      ano: anoController.text,
                      placa: placaController.text,
                      nomeDono: nomeController.text,
                      servico: servicoController.text,
                      pronto: prontoSelecionado,
                    );

                    try {
                      await CarroService.salvaCarro(carro);

                      if (!mounted) return;

                      limparCampos();
                      Navigator.pop(dialogContext);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Carro cadastrado com sucesso!'),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erro ao cadastrar: $e'),
                        ),
                      );
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // EDITAR CARRO
  void editarCarro(Carro carro) {
    final modeloEditController =
        TextEditingController(text: carro.modelo);
    final anoEditController =
        TextEditingController(text: carro.ano);
    final placaEditController =
        TextEditingController(text: carro.placa);
    final nomeEditController =
        TextEditingController(text: carro.nomeDono);
    final servicoEditController =
        TextEditingController(text: carro.servico);

    String statusEditado = carro.pronto;
    bool salvando = false;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, atualizarDialogo) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Editar Serviço'),
                  IconButton(
                    onPressed: () {
                      CarroService.deletarCarro(carro.id!);
                      Navigator.pop(dialogContext);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: modeloEditController,
                      decoration: const InputDecoration(
                        labelText: 'Modelo do veículo',
                      ),
                    ),
                    TextField(
                      controller: anoEditController,
                      decoration: const InputDecoration(
                        labelText: 'Ano do veículo',
                      ),
                    ),
                    TextField(
                      controller: placaEditController,
                      decoration: const InputDecoration(
                        labelText: 'Placa do veículo',
                      ),
                    ),
                    TextField(
                      controller: nomeEditController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do dono',
                      ),
                    ),
                    TextField(
                      controller: servicoEditController,
                      decoration: const InputDecoration(
                        labelText: 'Serviço',
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Status do serviço:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    RadioListTile<String>(
                      title: const Text('Pronto'),
                      value: 'Sim',
                      groupValue: statusEditado,
                      onChanged: (value) {
                        atualizarDialogo(() {
                          statusEditado = value!;
                        });
                      },
                    ),

                    RadioListTile<String>(
                      title: const Text('Não pronto'),
                      value: 'Não',
                      groupValue: statusEditado,
                      onChanged: (value) {
                        atualizarDialogo(() {
                          statusEditado = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: salvando
                      ? null
                      : () {
                          Navigator.pop(dialogContext);
                        },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: salvando
                      ? null
                      : () async {
                          if (carro.id == null || carro.id!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Não foi possível identificar o carro.',
                                ),
                              ),
                            );
                            return;
                          }

                          atualizarDialogo(() {
                            salvando = true;
                          });

                          final carroAtualizado = Carro(
                            id: carro.id,
                            modelo: modeloEditController.text,
                            ano: anoEditController.text,
                            placa: placaEditController.text,
                            nomeDono: nomeEditController.text,
                            servico: servicoEditController.text,
                            pronto: statusEditado,
                          );

                          try {
                            await CarroService.alterarCarro(
                              carro.id!,
                              carroAtualizado,
                            );

                            if (dialogContext.mounted) {
                              Navigator.pop(dialogContext);
                            }

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Carro atualizado com sucesso!',
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            print('Erro ao atualizar carro: $e');

                            if (dialogContext.mounted) {
                              atualizarDialogo(() {
                                salvando = false;
                              });
                            }

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Erro ao atualizar carro: $e',
                                  ),
                                ),
                              );
                            }
                          }
                        },
                  child: salvando
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Salvar alterações'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      modeloEditController.dispose();
      anoEditController.dispose();
      placaEditController.dispose();
      nomeEditController.dispose();
      servicoEditController.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Serviço de Oficina'),
      ),

      body: StreamBuilder<List<Carro>>(
        stream: CarroService.getCarros(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar carros: ${snapshot.error}',
              ),
            );
          }

          final carros = snapshot.data ?? [];

          if (carros.isEmpty) {
            return const Center(
              child: Text('Nenhum serviço encontrado.'),
            );
          }

          return ListView.builder(
            itemCount: carros.length,
            itemBuilder: (context, index) {
              final carro = carros[index];

              return Card(
                color: carro.pronto == 'Nao' || carro.pronto == 'Não' ? const Color.fromARGB(163, 255, 121, 121) : const Color.fromARGB(167, 169, 252, 172),
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    '${carro.modelo} - ${carro.placa}',
                  ),
                  subtitle: Text(
                    'Ano: ${carro.ano}\n'
                    'Dono: ${carro.nomeDono}\n'
                    'Serviço: ${carro.servico}\n'
                    'Pronto: ${carro.pronto}',
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Editar serviço',
                    onPressed: () {
                      editarCarro(carro);
                    },
                  ),

                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: abrirFormulario,
        child: const Icon(Icons.add),
      ),
    );
  }
}
