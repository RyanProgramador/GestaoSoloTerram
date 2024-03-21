// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

String? excluiVolumeDaEtapaAberta(
  dynamic trSinc,
  String? etiquetaNum,
) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  if (trSinc['etapas'] != null) {
    for (var etapa in trSinc['etapas']) {
      if (etapa['volumes'] != null) {
        for (var volume in etapa['volumes']) {
          if (volume['amostras'] != null) {
            volume['amostras'].removeWhere((amostra) =>
                amostra['volam_etiqueta_id'].toString() == etiquetaNum);

            //for(var item in volume['amostras']){
            //  if(item['volam_etiqueta_id'] !=null){
            //    item['volam_etiqueta_id'].removeWhere((item) => item['volam_etiqueta_id'].toString() ==  etiquetaNum);
            //  }
            //}
            //volume['amostras'].removeWhere((amostra) => amostra.toString() == etiquetaNum);
          }
        }
      }
    }
    return 'Amostra excluída com sucesso.';
  }
  return 'Nenhuma etapa ou volume encontrado.';

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
