// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
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
  String formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(dateTime);
  }

  var lista = FFAppState().PontosColetados.where((element) =>
      element['oserv_id'] == oservid.toString() &&
      element['faz_id'] == fazId.toString());

  Map<int, List<Map<String, dynamic>>> groupedByPontoId = {};

  for (var item in lista) {
    int idPonto = int.parse(item["id_ponto"]);
    int marcador_nome = int.parse(item["marcador_nome"]);

    if (!groupedByPontoId.containsKey(idPonto)) {
      groupedByPontoId[idPonto] = [];
    }
    groupedByPontoId[idPonto]!.add(item);
  }

  List<Map<String, dynamic>> transformedList = [];

  groupedByPontoId.forEach((idPonto, items) {
    var profundidades = items
        .map((item) => {
              "pprof_id": int.parse(item["profundidade"]),
              "pprof_status": 1,
              "pprof_icone": item['profundidade'],
              "pprof_observacao": item["obs"].toString() ?? "Sem observação!",
              "pprof_foto": item["foto"].toString() ?? "",
              "pprof_datahora": formatDateTime(item["data_hora"].toString()),
            })
        .toList();

    transformedList.add({
      "pont_id": idPonto,
      "pont_numero": items.first["marcador_nome"],
      "pont_latitude": "",
      "pont_longitude": "",
      "pont_simbolo": "Pin, Green",
      "pont_status": 1,
      "pont_observacao": "",
      "pont_foto": "",
      "profundidades": profundidades,
    });
  });

  var listaIna = FFAppState().PontosInacessiveis.where((element) =>
      element['oserv_id'] == oservid.toString() &&
      element['faz_id'] == fazId.toString());

  Map<int, List<Map<String, dynamic>>> groupedByPontoIdInacessivel = {};

  for (var item in listaIna) {
    int idPonto = int.parse(item["id_ponto"]);

    if (!groupedByPontoIdInacessivel.containsKey(idPonto)) {
      groupedByPontoIdInacessivel[idPonto] = [];
    }
    groupedByPontoIdInacessivel[idPonto]!.add(item);
  }

  List<Map<String, dynamic>> transformedListInacessiveis = [];

  groupedByPontoIdInacessivel.forEach((idPonto, items) {
    for (var item in items) {
      var profundidades = items
          .map((item) => {
                "pprof_id": item["profundidade"],
                "pprof_status": 2,
                "pprof_icone": item['profundidade'],
                "pprof_observacao": "",
                "pprof_foto": "",
                "pprof_datahora": formatDateTime(item["data_hora"].toString()),
              })
          .toList();

      transformedListInacessiveis.add({
        "pont_id": idPonto,
        "pont_numero": items.first["marcador_nome"],
        "pont_latitude": "",
        "pont_longitude": "",
        "pont_simbolo": "",
        "pont_status": 2,
        "pont_observacao": items.first["obs"].toString(),
        "pont_foto": items.first["foto"].toString(),
        "profundidades": profundidades,
      });
    }
  });
  var jaExisteTrSincroniza = FFAppState()
      .trSincroniza
      .where((element) =>
          element['fazenda_id'] == fazId.toString() &&
          element['servico_id'] == oservid.toString())
      .toList();

  // Checa se algum elemento foi encontrado
  if (jaExisteTrSincroniza.isNotEmpty) {
    // Atualiza o primeiro elemento encontrado
    // Esta é uma abordagem simplificada; ajuste conforme a necessidade de sua aplicação
    int index = FFAppState().trSincroniza.indexOf(jaExisteTrSincroniza.first);
    if (index != -1) {
      // Verifica se encontrou o índice corretamente
      var listaCompleta = transformedList + transformedListInacessiveis;

      FFAppState().trSincroniza[index] =
          await atualizaListas(FFAppState().trSincroniza[index], listaCompleta);
    }
  } else {
    // Adiciona um novo elemento, pois não foi encontrado nenhum correspondente
    FFAppState().trSincroniza.add({
      "fazenda_id": fazId.toString(),
      "servico_id": oservid.toString(),
      "pontos": transformedList + transformedListInacessiveis,
    });
  }
}
