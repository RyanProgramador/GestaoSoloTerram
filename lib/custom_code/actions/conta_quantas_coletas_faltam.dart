// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
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
              element['oserv_id'] == oservId.toString &&
              element['faz_id'] == fazId.toString)
          .length +
      FFAppState()
          .PontosInacessiveis
          .where((element) =>
              element['oserv_id'] == oservId.toString &&
              element['faz_id'] == fazId.toString)
          .length;

  // Aqui você calcula quantas coletas faltam e converte o resultado para String
  // Garantindo que aColetar não seja null antes de realizar a operação
  int faltam = aColetar != null ? aColetar - registros : 0;
  return faltam.toString();
}
