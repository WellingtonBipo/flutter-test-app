import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app_teste_tecnio_wk/model/criar_pessoa_model.dart';
import 'package:app_teste_tecnio_wk/model/pessoa_info_model.dart';

class ApiModel {
  final Map<String, String> _headers = {
    "Content-type": "application/json",
  };

  Future<List<PessoaInfoModel>> getPessoas() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/pessoas'));
    if (response.statusCode >= 300) throw Exception();
    final decoded = jsonDecode(response.body);
    return (decoded as List).map((e) => PessoaInfoModel.fromMap(e)).toList();
  }

  Future<void> postPessoa(CriarPessoaModel pessoa) async {
    final response = await http.post(Uri.parse('http://10.0.2.2:8080/pessoas'),
        body: pessoa.toJson(), headers: _headers);
    if (response.statusCode >= 300) throw Exception();
  }

  Future<void> deletePessoa(int id) async {
    final response =
        await http.delete(Uri.parse('http://10.0.2.2:8080/pessoas/$id'));
    if (response.statusCode >= 300) throw Exception();
  }

  Future<void> putPessoa(PessoaInfoModel pessoa) async {
    final response = await http.put(Uri.parse('http://10.0.2.2:8080/pessoas'),
        body: pessoa.toJson(), headers: _headers);
    if (response.statusCode >= 300) throw Exception();
  }
}
