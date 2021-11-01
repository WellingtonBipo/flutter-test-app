import 'dart:convert';

import 'package:app_teste_tecnio_wk/core/enums.dart';

class CriarPessoaModel {
  final String nome;
  final DateTime dataNascimento;
  final Sexo sexo;
  final String fotoAsString;
  final String ruaNumero;
  final String? complemento;
  final int cep;
  final String bairro;
  final String cidade;
  final String estado;
  final String pais;

  CriarPessoaModel({
    required this.nome,
    required this.dataNascimento,
    required this.sexo,
    required this.fotoAsString,
    required this.ruaNumero,
    this.complemento,
    required this.cep,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.pais,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'dataNascimento': dataNascimento.toIso8601String(),
      'sexo': sexo.toString().split('.').last.toLowerCase(),
      'fotoAsString': fotoAsString,
      'ruaNumero': ruaNumero,
      'complemento': complemento,
      'cep': cep,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'pais': pais,
    };
  }

  String toJson() => json.encode(toMap());
}
