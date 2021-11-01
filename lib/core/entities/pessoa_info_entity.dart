import 'package:app_teste_tecnio_wk/core/enums.dart';

class PessoaInfoEntity {
  final int id;
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

  PessoaInfoEntity({
    required this.id,
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
}
