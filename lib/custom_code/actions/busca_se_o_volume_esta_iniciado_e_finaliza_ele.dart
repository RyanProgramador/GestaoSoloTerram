// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<bool> buscaSeOVolumeEstaIniciadoEFinalizaEle(
  BuildContext context,
  dynamic trSinc,
  String? qrCode,
) async {
  if (trSinc['etapas'] != null && trSinc['etapas'].isNotEmpty) {
    for (var etapa in trSinc['etapas']) {
      if (etapa['etap_fim'] == null || etapa['etap_fim'].isEmpty) {
        if (etapa['volumes'] != null && etapa['volumes'].isNotEmpty) {
          for (var volume in etapa['volumes']) {
            if (volume['volume_data_hora_fim'] == null ||
                volume['volume_data_hora_fim'].isEmpty) {
              volume['lacre'] = qrCode.toString();
              volume['volume_data_hora_fim'] =
                  DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

              return true; // Finalizou o volume
            }
          }
        }
      }
    }
  }
  return false;
}
