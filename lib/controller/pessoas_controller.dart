import 'package:app_teste_tecnio_wk/core/entities/pessoa_info_entity.dart';
import 'package:app_teste_tecnio_wk/model/api_model.dart';
import 'package:app_teste_tecnio_wk/model/criar_pessoa_model.dart';
import 'package:app_teste_tecnio_wk/model/pessoa_info_model.dart';
import 'package:flutter/material.dart';

class PessoasController extends ChangeNotifier {
  static final PessoasController _instancia = PessoasController._();
  PessoasController._();
  factory PessoasController() => _instancia;

  final ApiModel _api = ApiModel();

  List<PessoaInfoEntity> _pessoas = [];

  List<PessoaInfoEntity> get pessoas => _pessoas;

  Future<void> atualizarPessoas() async {
    _pessoas = await _api.getPessoas();
    notifyListeners();
  }

  Future<void> adicionarEditarPessoa({
    int? id,
    required CriarPessoaModel pessoa,
  }) async {
    if (id != null) {
      await _api.putPessoa(PessoaInfoModel(
        id: id,
        nome: pessoa.nome,
        dataNascimento: pessoa.dataNascimento,
        sexo: pessoa.sexo,
        fotoAsString: pessoa.fotoAsString,
        ruaNumero: pessoa.ruaNumero,
        complemento: pessoa.complemento,
        cep: pessoa.cep,
        bairro: pessoa.bairro,
        cidade: pessoa.cidade,
        estado: pessoa.estado,
        pais: pessoa.pais,
      ));
    } else {
      await _api.postPessoa(pessoa);
    }
    await atualizarPessoas();
    notifyListeners();
  }

  Future<void> deletarPessoa(int id) async {
    await _api.deletePessoa(id);
    await atualizarPessoas();
    notifyListeners();
  }
}
