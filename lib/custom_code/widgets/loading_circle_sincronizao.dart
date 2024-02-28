// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';

class LoadingCircleSincronizao extends StatefulWidget {
  const LoadingCircleSincronizao({
    Key? key,
    this.width,
    this.height,
    this.color,
    this.circleRadius,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double? circleRadius;
  final Color? color;

  @override
  _LoadingCircleSincronizaoState createState() =>
      _LoadingCircleSincronizaoState();
}

class _LoadingCircleSincronizaoState extends State<LoadingCircleSincronizao> {
  Timer? _timer;
  int _messageIndex = 0;
  final List<String> _messages = [
    "Isso irá demorar um pouco",
    "Estamos processando os dados",
    "Isso pode levar alguns minutos",
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _messageIndex = (_messageIndex + 1) % _messages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Não desligue ou saia do aplicativo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18, // Define o tamanho da fonte para 18
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20), // Espaço entre o texto e o indicador
        Container(
          width: widget.width,
          height: widget.height,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: widget.circleRadius ?? 5.0,
              valueColor:
                  AlwaysStoppedAnimation<Color>(widget.color ?? Colors.blue),
            ),
          ),
        ),
        SizedBox(height: 20), // Espaço entre o indicador e o texto abaixo
        Text(_messages[_messageIndex],
            style: TextStyle(
                color:
                    Colors.white)), // Mostra o texto que muda a cada 3 segundos
      ],
    );
  }
}
