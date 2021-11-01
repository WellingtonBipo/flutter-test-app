import 'dart:convert';

import 'package:app_teste_tecnio_wk/core/entities/pessoa_info_entity.dart';
import 'package:app_teste_tecnio_wk/core/enums.dart';

class PessoaInfoModel extends PessoaInfoEntity {
  PessoaInfoModel({
    required int id,
    required String nome,
    required DateTime dataNascimento,
    required Sexo sexo,
    required String fotoAsString,
    required String ruaNumero,
    required String? complemento,
    required int cep,
    required String bairro,
    required String cidade,
    required String estado,
    required String pais,
  }) : super(
          id: id,
          nome: nome,
          dataNascimento: dataNascimento,
          sexo: sexo,
          fotoAsString: fotoAsString,
          ruaNumero: ruaNumero,
          complemento: complemento,
          cep: cep,
          bairro: bairro,
          cidade: cidade,
          estado: estado,
          pais: pais,
        );

  factory PessoaInfoModel.fromMap(Map<String, dynamic> map) {
    DateTime? dateParsed = DateTime.tryParse(map['dataNascimento']);
    if (dateParsed == null) {
      final splited = (map['dataNascimento'] as String)
          .split('/')
          .map((e) => int.parse(e))
          .toList();
      dateParsed = DateTime(splited[2], splited[1], splited[0]);
    }
    return PessoaInfoModel(
      id: map['id'],
      nome: map['nome'],
      dataNascimento: dateParsed,
      sexo: Sexo.values.firstWhere((element) =>
          element.toString().split('.').last.toLowerCase() ==
          map['sexo'].toLowerCase()),
      fotoAsString: map['fotoAsString'],
      ruaNumero: map['ruaNumero'],
      complemento: map['complemento'],
      cep: map['cep'],
      bairro: map['bairro'],
      cidade: map['cidade'],
      estado: map['estado'],
      pais: map['pais'],
    );
  }

  factory PessoaInfoModel.fromJson(String source) =>
      PessoaInfoModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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
