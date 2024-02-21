// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'dart:typed_data';

class IconeComLegenda extends StatefulWidget {
  const IconeComLegenda({
    Key? key,
    this.width,
    this.height,
    required this.lista, // Assume que a lista é passada aqui
    this.termoDePesquisa,
    this.pathDePesquisa,
    this.pathDeRetorno,
    this.pathDeLegenda,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<dynamic> lista; // A lista é passada como um parâmetro obrigatório
  final String? termoDePesquisa;
  final String? pathDePesquisa;
  final String? pathDeRetorno;
  final String? pathDeLegenda;
  @override
  State<IconeComLegenda> createState() => _IconeComLegendaState();
}

class _IconeComLegendaState extends State<IconeComLegenda> {
  Uint8List? imagemBase64;

  @override
  void initState() {
    super.initState();
    _buscarIcone();
  }

  void _buscarIcone() {
    // Procura na lista FFAppState().trIcones pelo termo de pesquisa
    final itemEncontrado = FFAppState().trIcones.firstWhere(
          (item) => item['ico_valor'] == widget.termoDePesquisa,
          orElse: () => null,
        );

    if (itemEncontrado != null) {
      final String base64String = itemEncontrado['ico_base64'];
      setState(() {
        imagemBase64 = base64Decode(base64String.split(',').last);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width,
      height: widget.height ?? 50, // Altura padrão se não for fornecida
      child: imagemBase64 != null
          ? Image.memory(imagemBase64!, width: 20, height: 20)
          : const Text('Ícone não encontrado.'),
    );
  }
}
