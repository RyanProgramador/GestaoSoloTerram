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
      children: [
        // Use Image.memory to display the image
        if (widget.base64Foto != null)
          Image.memory(imageBytes,
              width: widget.width ?? 50, height: widget.height ?? 50),
        SizedBox(width: 10),
        // Your code continues here...
      ],
    );
  }
}
