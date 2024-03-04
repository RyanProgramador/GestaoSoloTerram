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

class FotoBase64 extends StatefulWidget {
  const FotoBase64({
    super.key,
    this.width,
    this.height,
    this.base64Foto,
  });

  final double? width;
  final double? height;
  final String? base64Foto;

  @override
  State<FotoBase64> createState() => _FotoBase64State();
}

class _FotoBase64State extends State<FotoBase64> {
  @override
  Widget build(BuildContext context) {
    // Convert the base64 String to a Uint8List
    Uint8List imageBytes = base64Decode(widget.base64Foto!);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Use Image.memory to display the image
        if (widget.base64Foto != null)
          // Expanded( // Faz a imagem ocupar
          ClipRect(
            // Use ClipRect para recortar a imagem se necessário
            clipper: MyClipper(),
            child: Image.memory(
              imageBytes,
              fit: BoxFit.cover, // Garante que a imagem preencha o espaço
              // Para o recorte específico, considere ajustar a imagem antes de carregar aqui
            ),
          ),
        // ),
      ],
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // Recorta 20px do topo e do fundo da imagem.
    // Altere esses valores conforme necessário.
    return Rect.fromLTRB(0, 25, size.width, size.height - 25);
  }

  @override
  bool shouldReclip(oldClipper) {
    // Retorna true se o clipper for recriado com diferentes configurações.
    // Caso contrário, retorna false.
    return false;
  }
}
