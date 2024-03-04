// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
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
import 'package:flutter_svg/flutter_svg.dart';

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
  String svg = ''; // Inicializa a variável SVG como uma string vazia
  final String svgString = '''
<svg xmlns="http://www.w3.org/2000/svg" width="384" height="511" viewBox="0 0 384 511" fill="none">
<path d="M383 192C383 213.653 375.746 239.621 363.996 267.455C352.252 295.272 336.052 324.875 318.236 353.775C282.606 411.574 240.56 466.486 214.921 498.573C203.021 513.376 180.979 513.376 169.079 498.573C143.44 466.486 101.394 411.574 65.7637 353.775C47.9478 324.875 31.7476 295.272 20.0041 267.455C8.25363 239.621 1 213.653 1 192C1 86.5523 86.5523 1 192 1C297.448 1 383 86.5523 383 192ZM237.962 146.038C225.772 133.848 209.239 127 192 127C174.761 127 158.228 133.848 146.038 146.038C133.848 158.228 127 174.761 127 192C127 209.239 133.848 225.772 146.038 237.962C158.228 250.152 174.761 257 192 257C209.239 257 225.772 250.152 237.962 237.962C250.152 225.772 257 209.239 257 192C257 174.761 250.152 158.228 237.962 146.038Z" fill="#09335A" stroke="black" stroke-width="2"/>
</svg>''';

  @override
  void initState() {
    super.initState();
    _buscarIcone();
  }

  void _buscarIcone() {
    // Procura na lista FFAppState().trIcones pelo termo de pesquisa
    final itemEncontrado = FFAppState().trIcones.firstWhere(
          (item) => item['ico_valor'] == widget.termoDePesquisa,
          // (item) => item['ico_valor'] == 'Waypoint',
          orElse: () => null,
        );

    if (itemEncontrado != null) {
      setState(() {
        String rawSvg = itemEncontrado['ico_svg'];

        // Remove caracteres de nova linha e possíveis barras invertidas antes de armazenar na variável svg
        svg = rawSvg.replaceAll(r'\n', '').replaceAll(r'\\', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Utiliza SvgPicture.string para renderizar o SVG diretamente da string
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width,
      height: widget.height ?? 50, // Altura padrão se não for fornecida
      child: SvgPicture.string(
        svg,
        width: 20,
        height: 20,
        // Adiciona um BoxFit para garantir que o SVG seja exibido corretamente
        fit: BoxFit.contain,
      ),
      // text: (svg);
    );
  }
}
