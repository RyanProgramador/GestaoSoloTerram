// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<String> contaQuantasColetasFaltam(
  String? fazId,
  String? oservId,
  int? aColetar,
) async {
  int registros = FFAppState()
          .PontosColetados
          .where((element) =>
              element['oserv_id'] == widget.oservid &&
              element['faz_id'] == widget.fazId)
          .length +
      FFAppState()
          .PontosInacessiveis
          .where((element) =>
              element['oserv_id'] == widget.oservid &&
              element['faz_id'] == widget.fazId)
          .length;
  return registros - aColetar;
}
