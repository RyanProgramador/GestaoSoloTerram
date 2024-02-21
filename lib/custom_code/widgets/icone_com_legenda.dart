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
    this.lista,
    this.termoDePesquisa,
    this.pathDePesquisa,
    this.pathDeRetorno,
    this.pathDeLegenda,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<dynamic>? lista;
  final String? termoDePesquisa;
  final String? pathDePesquisa;
  final String? pathDeRetorno;
  final String? pathDeLegenda;

  @override
  State<IconeComLegenda> createState() => _IconeComLegendaState();
}

class _IconeComLegendaState extends State<IconeComLegenda> {
  Uint8List? imagemBase64;
  String? legenda;

  @override
  void initState() {
    super.initState();
    _buscarIconeELegenda();
  }

  void _buscarIconeELegenda() {
    // Procura na lista pelo termo de pesquisa
    final itemEncontrado = widget.lista?.firstWhere(
      (item) => item[widget.pathDePesquisa] == widget.termoDePesquisa,
      orElse: () => null,
    );

    if (itemEncontrado != null) {
      final String base64String = itemEncontrado[widget.pathDeRetorno];
      imagemBase64 = base64Decode(base64String.split(',').last);
      legenda = itemEncontrado[widget.pathDeLegenda];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: imagemBase64 != null && legenda != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.memory(
                  imagemBase64!,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 8),
                Text(legenda!),
              ],
            )
          : const Text('Ícone ou legenda não encontrados.'),
    );
  }
}
