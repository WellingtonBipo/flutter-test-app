import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:app_teste_tecnio_wk/controller/pessoas_controller.dart';
import 'package:app_teste_tecnio_wk/core/extensions.dart';
import 'package:app_teste_tecnio_wk/view/criar_editar_pessoa_view.dart';
import 'package:app_teste_tecnio_wk/core/entities/pessoa_info_entity.dart';

class CardPessoaInfo extends StatelessWidget {
  final PessoaInfoEntity info;
  late final ImageProvider? image;

  CardPessoaInfo({
    Key? key,
    required this.info,
  }) : super(key: key) {
    try {
      image = MemoryImage(const Base64Codec().decode(info.fotoAsString));
    } catch (e) {
      image = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.indigo.shade900,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            DefaultTextStyle(
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nome: ${info.nome}'),
                    const Divider(color: Colors.grey, height: 8),
                    Text(
                        'Data de nascimento: ${DateFormat('dd/MM/yyyy').format(info.dataNascimento)}'),
                    const Divider(color: Colors.grey, height: 8),
                    Text(
                        'Sexo: ${info.sexo.toString().split('.').last.capitalize()}'),
                    const Divider(color: Colors.grey, height: 8),
                    Text('Endereço: ${info.ruaNumero}'),
                    Text('${info.cidade} - ${info.estado} - ${info.pais}'),
                    Text('CEP: ${info.cep}'),
                    const Divider(color: Colors.grey, height: 8),
                    Text('Codigo: ${info.id}'),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  foregroundImage: image,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => CriarEditarPessoaView(info: info)));
                      },
                      child: const Icon(Icons.edit, color: Colors.white),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () async {
                        final result = await showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: const Text(
                                    'Tem certeza que deseja excluir esse usuário?'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('Sim'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Não'),
                                  ),
                                ],
                              );
                            });
                        if (result) PessoasController().deletarPessoa(info.id);
                      },
                      child: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
