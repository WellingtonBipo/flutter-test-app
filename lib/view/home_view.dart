import 'dart:async';

import 'package:app_teste_tecnio_wk/controller/pessoas_controller.dart';
import 'package:app_teste_tecnio_wk/core/entities/pessoa_info_entity.dart';
import 'package:app_teste_tecnio_wk/view/criar_editar_pessoa_view.dart';
import 'package:app_teste_tecnio_wk/widgets/card_pessoa_info.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final StreamController<String> _controller = StreamController<String>();
  final PessoasController pessoaController = PessoasController();

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    pessoaController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GERENCIADOR DE PESSOAS'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const CriarEditarPessoaView()));
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CriarEditarPessoaView()));
        },
        backgroundColor: Colors.indigo.shade900,
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await pessoaController.atualizarPessoas();
        },
        child: Column(
          children: [
            _filter(),
            Expanded(child: _itens()),
          ],
        ),
      ),
    );
  }

  Widget _filter() => Padding(
        padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
        child: TextField(
          decoration: const InputDecoration(hintText: 'Procure pelo nome'),
          onChanged: (text) {
            _controller.add(text);
          },
        ),
      );

  Widget _itens() => StreamBuilder<String>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        List<PessoaInfoEntity> list = [...pessoaController.pessoas];
        if (snapshot.hasData && snapshot.data != null) {
          list = list
              .where((element) => element.nome
                  .toLowerCase()
                  .contains(snapshot.data!.toLowerCase()))
              .toList();
        }

        return ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: list.length,
          itemBuilder: (_, index) {
            return CardPessoaInfo(info: list[index]);
          },
          separatorBuilder: (_, __) {
            return const SizedBox(height: 10);
          },
        );
      });
}
