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

Future atualizaTrSinc(
  int? fazId,
  int? oservid,
) async {
  // String formatDateTime(String dateTimeStr) {
  //   DateTime dateTime = DateTime.parse(dateTimeStr);
  //   DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  //   return formatter.format(dateTime);
  // }
  //
  // var lista = FFAppState().PontosColetados.where((element) =>
  //     element['oserv_id'] == oservid.toString() &&
  //     element['faz_id'] == fazId.toString());
  //
  // Map<int, List<Map<String, dynamic>>> groupedByPontoId = {};
  //
  // for (var item in lista) {
  //   int idPonto = int.parse(item["id_ponto"]);
  //   int marcador_nome = int.parse(item["marcador_nome"]);
  //
  //   if (!groupedByPontoId.containsKey(idPonto)) {
  //     groupedByPontoId[idPonto] = [];
  //   }
  //   groupedByPontoId[idPonto]!.add(item);
  // }
  //
  // List<Map<String, dynamic>> transformedList = [];
  //
  // groupedByPontoId.forEach((idPonto, items) {
  //   var profundidades = items
  //       .map((item) => {
  //             "pprof_id": int.parse(item["profundidade"]),
  //             "pprof_status": 1,
  //             "pprof_icone": item['profundidade'],
  //             "pprof_observacao": item["obs"].toString() ?? "Sem observação!",
  //             "pprof_foto": item["foto"].toString() ?? "Sem foto",
  //             "pprof_datahora": formatDateTime(item["data_hora"].toString()),
  //           })
  //       .toList();
  //
  //   transformedList.add({
  //     "pont_id": idPonto,
  //     "pont_numero": items.first["marcador_nome"],
  //     "pont_latitude": "",
  //     "pont_longitude": "",
  //     "pont_simbolo": "",
  //     "pont_status": 1,
  //     "pont_observacao": "",
  //     "pont_foto": "",
  //     "profundidades": profundidades,
  //   });
  // });
  //
  // var listaIna = FFAppState().PontosInacessiveis.where((element) =>
  //     element['oserv_id'] == oservid.toString() &&
  //     element['faz_id'] == fazId.toString());
  //
  // Map<int, List<Map<String, dynamic>>> groupedByPontoIdInacessivel = {};
  //
  // for (var item in listaIna) {
  //   int idPonto = int.parse(item["id_ponto"]);
  //
  //   if (!groupedByPontoIdInacessivel.containsKey(idPonto)) {
  //     groupedByPontoIdInacessivel[idPonto] = [];
  //   }
  //   groupedByPontoIdInacessivel[idPonto]!.add(item);
  // }
  //
  // List<Map<String, dynamic>> transformedListInacessiveis = [];
  //
  // groupedByPontoIdInacessivel.forEach((idPonto, items) {
  //   for (var item in items) {
  //     String foto = item["foto"].toString();
  //     String obs = item["obs"].toString();
  //     var profundidades = items
  //         .map((item) => {
  //               "pprof_id": item["profundidade"],
  //               "pprof_status": 2,
  //               "pprof_icone": item['profundidade'],
  //               "pprof_observacao": "",
  //               "pprof_foto": "",
  //               "pprof_datahora": formatDateTime(item["data_hora"].toString()),
  //             })
  //         .toList();
  //
  //     transformedListInacessiveis.add({
  //       "pont_id": idPonto,
  //       "pont_numero": item["marcador_nome"],
  //       "pont_latitude": "",
  //       "pont_longitude": "",
  //       "pont_simbolo": "",
  //       "pont_status": 2,
  //       "pont_observacao":obs,
  //       "pont_foto": foto,
  //       "profundidades": profundidades,
  //     });
  //   }
  // });
  // var jaExisteTrSincroniza = FFAppState()
  //     .trSincroniza
  //     .where((element) =>
  // element['fazenda_id'] == fazId && element['servico_id'] == oservid)
  //     .toList();
  //
  // // 7. Check if synchronized data exists
  // if (jaExisteTrSincroniza.isNotEmpty) {
  //   // 7.1 Update existing synchronized data (assuming you want to replace all points)
  //
  //   int index = FFAppState().trSincroniza.indexOf(FFAppState()
  //       .trSincroniza
  //       .firstWhere((element) =>
  //   element['fazenda_id'].toString() == fazId.toString() && element['servico_id'].toString() == oservid.toString()));
  //   print(index);
  //   var teste = FFAppState().trSincroniza[index]["pontos"];
  //   if (index != -1) {
  //     FFAppState().trSincroniza[index] = {
  //       "fazenda_id": fazId,
  //       "servico_id": oservid,
  //       "pontos": teste + transformedList + transformedListInacessiveis,
  //     };
  //   }
  // } else {
  //   // 7.2 Add new synchronized data
  //   FFAppState().trSincroniza.add({
  //     "fazenda_id": fazId,
  //     "servico_id": oservid,
  //     "pontos": transformedList + transformedListInacessiveis,
  //   });
  // }
}
