import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import 'package:app_teste_tecnio_wk/controller/pessoas_controller.dart';
import 'package:app_teste_tecnio_wk/core/enums.dart';
import 'package:app_teste_tecnio_wk/model/criar_pessoa_model.dart';
import 'package:app_teste_tecnio_wk/core/entities/pessoa_info_entity.dart';

class CriarEditarPessoaView extends StatefulWidget {
  final PessoaInfoEntity? info;
  const CriarEditarPessoaView({
    Key? key,
    this.info,
  }) : super(key: key);

  @override
  State<CriarEditarPessoaView> createState() => _CriarEditarPessoaViewState();
}

class _CriarEditarPessoaViewState extends State<CriarEditarPessoaView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dataNascimentoController =
      TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _paisController = TextEditingController();
  Sexo? _sexo;
  Uint8List? _fotoFile;

  @override
  void initState() {
    super.initState();
    if (widget.info != null) {
      _nomeController.text = widget.info!.nome;
      _dataNascimentoController.text =
          DateFormat('dd/MM/yyyy').format(widget.info!.dataNascimento);
      _cepController.text = widget.info!.cep.toString();
      _ruaController.text = widget.info!.ruaNumero;
      _complementoController.text = widget.info!.complemento ?? '';
      _bairroController.text = widget.info!.bairro;
      _cidadeController.text = widget.info!.cidade;
      _estadoController.text = widget.info!.estado;
      _paisController.text = widget.info!.pais;
      _sexo = widget.info!.sexo;
      try {
        _fotoFile = const Base64Codec().decode(widget.info!.fotoAsString);
      } catch (e) {
        _fotoFile = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.info == null ? 'CRIAR PESSOA' : 'EDITAR PESSOA'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  _fotoImage(),
                  const SizedBox(height: 20),
                  _field(title: 'Nome:', controller: _nomeController),
                  const SizedBox(height: 10),
                  _field(
                    title: 'Data de nascimento:',
                    controller: _dataNascimentoController,
                    isDate: true,
                  ),
                  const SizedBox(height: 20),
                  _sexoRow(),
                  const SizedBox(height: 10),
                  _field(
                    title: 'CEP:',
                    controller: _cepController,
                  ),
                  const SizedBox(height: 10),
                  _field(
                    title: 'Rua:',
                    controller: _ruaController,
                  ),
                  const SizedBox(height: 10),
                  _field(
                    title: 'Complemento:',
                    controller: _complementoController,
                    obrigatorio: false,
                  ),
                  const SizedBox(height: 10),
                  _field(
                    title: 'Bairro:',
                    controller: _bairroController,
                  ),
                  const SizedBox(height: 10),
                  _field(
                    title: 'Cidade:',
                    controller: _cidadeController,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _field(
                          title: 'Estado:',
                          controller: _estadoController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _field(
                          title: 'País:',
                          controller: _paisController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _rowButtons(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _fotoImage() => GestureDetector(
        onTap: () async {
          final image = await ImagePicker().pickImage(
            source: ImageSource.camera,
            maxWidth: 600,
          );
          if (image == null) return;
          setState(() {
            _fotoFile = File(image.path).readAsBytesSync();
          });
        },
        child: Container(
          height: 200,
          width: 200,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.indigo,
          ),
          child: _fotoFile == null
              ? const Center(
                  child: Text(
                    'Adicionar foto',
                    softWrap: true,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )
              : FittedBox(
                  fit: BoxFit.cover,
                  child: Image.memory(_fotoFile!),
                ),
        ),
      );

  Widget _field({
    String? title,
    TextEditingController? controller,
    bool isDate = false,
    bool obrigatorio = true,
  }) =>
      TextFormField(
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        readOnly: isDate,
        validator: obrigatorio
            ? (text) {
                if (text == null || text.isEmpty) {
                  return 'Este campos é obrigatório';
                }
              }
            : null,
        onTap: isDate
            ? () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate:
                      DateTime.now().subtract(const Duration(days: 365 * 18)),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  _dataNascimentoController.text =
                      DateFormat('dd/MM/yyyy').format(date);
                }
              }
            : null,
        decoration: InputDecoration(
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: title == null
              ? null
              : Text(
                  title,
                  style: TextStyle(
                    color: Colors.indigo.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
        ),
      );

  Widget _sexoRow() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sexo:',
            style: TextStyle(
              color: Colors.indigo.shade900,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: const Text('Feminimo'),
                  value: _sexo == Sexo.feminimo,
                  onChanged: (_) {
                    setState(() => _sexo = Sexo.feminimo);
                  },
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: CheckboxListTile(
                  title: const Text('Masculino'),
                  value: _sexo == Sexo.masculino,
                  onChanged: (_) {
                    setState(() => _sexo = Sexo.masculino);
                  },
                ),
              )
            ],
          ),
        ],
      );

  Widget _rowButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            child: const Text('Cancelar'),
            style: ElevatedButton.styleFrom(fixedSize: const Size(120, 30)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text('Salvar'),
            style: ElevatedButton.styleFrom(fixedSize: const Size(120, 30)),
            onPressed: () async {
              try {
                if (!_validarCampos()) return;

                final dateSplited = _dataNascimentoController.text
                    .split('/')
                    .map((e) => int.parse(e))
                    .toList();

                await PessoasController().adicionarEditarPessoa(
                    id: widget.info?.id,
                    pessoa: CriarPessoaModel(
                      nome: _nomeController.text,
                      dataNascimento: DateTime(
                          dateSplited[2], dateSplited[1], dateSplited[0]),
                      sexo: _sexo!,
                      fotoAsString:
                          const Base64Codec().encode(_fotoFile!.toList()),
                      ruaNumero: _ruaController.text,
                      cep: int.parse(_cepController.text),
                      bairro: _bairroController.text,
                      cidade: _cidadeController.text,
                      estado: _estadoController.text,
                      pais: _paisController.text,
                    ));

                Navigator.of(context).pop();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao criar pessoa\nErro: $e')));
              }
            },
          ),
        ],
      );

  bool _validarCampos() {
    String? result;
    if (!_formKey.currentState!.validate()) {
      result = 'Alguns campos precisam ser preenchidos';
    } else if (_fotoFile == null) {
      result = 'É preciso escolher uma foto';
    } else if (_sexo == null) {
      result = 'É preciso escolher o sexo';
    }

    if (result != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
      return false;
    }
    return true;
  }
}
