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
    // Cria um objeto DateTime a partir da string
    DateTime dateTime = DateTime.parse(dateTimeStr);
    // Cria um formatador com o padrão desejado
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    // Retorna a string formatada
    return formatter.format(dateTime);
  }

  var lista = FFAppState().PontosColetados.where((element) =>
      element['oserv_id'] == oservid.toString() &&
      element['faz_id'] == fazId.toString());

  Map<int, List<Map<String, dynamic>>> groupedByPontoId = {};

  for (var item in lista) {
    // Tenta converter o valor de item["id_ponto"] para int, se não for possível, atribui 0 ou trata o erro de outra forma.
    int idPonto = (int.parse(item["id_ponto"]) as int?) ?? 0;
    int marcador_nome =
        (int.parse(item["marcador_nome"]) as int?) ?? 0; /* id numero valor */

    if (!groupedByPontoId.containsKey(idPonto)) {
      groupedByPontoId[idPonto] = [];
    }
    groupedByPontoId[idPonto]!.add(item);
  }

  List<Map<String, dynamic>> transformedList = [];

  groupedByPontoId.forEach((idPonto, items) {
    // for (var item in items) {
    var profundidades = items
        .map((item) => {
              "pprof_id": int.parse(item["profundidade"]),
              "pprof_status": 1,
              "pprof_icone": "Pin, Green",
              "pprof_observacao": item["obs"].toString() ?? "Sem observação!",
              "pprof_foto": item["fot"].toString() ?? "",
              "pprof_datahora": formatDateTime(item["data_hora"].toString()),
            })
        .toList();
    // var splittedLatLng = item["latlng"].split(",");
    //
    // var latitude = double.parse(splittedLatLng[0]);
    // var longitude = double.parse(splittedLatLng[1]);

    transformedList.add({
      "pont_id": idPonto,
      "pont_numero": 393, //item["marcador_nome"],
      "pont_latitude": "-17.780151593", //latitude.toString(),
      "pont_longitude": "-51.061255731", //longitude.toString(),
      "pont_simbolo": "Pin, Green",
      "pont_status": 1,
      "pont_observacao": "",
      "pont_foto": "",
      "profundidades": profundidades,
    });
    // }
  });

  var listaIna = FFAppState().PontosInacessiveis.where((element) =>
      element['oserv_id'] == oservid.toString() &&
      element['faz_id'] == fazId.toString());

  Map<int, List<Map<String, dynamic>>> groupedByPontoIdInacessivel = {};

  for (var item in listaIna) {
    // Tenta converter o valor de item["id_ponto"] para int, se não for possível, atribui 0 ou trata o erro de outra forma.
    int idPonto = (int.parse(item["id_ponto"]) as int?) ?? 0;

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
                "pprof_icone": "pin sla",
                "pprof_observacao": "",
                "pprof_foto": "",
                "pprof_datahora": formatDateTime(item["data_hora"].toString()),
              })
          .toList();

      transformedListInacessiveis.add({
        "pont_id": idPonto,
        "pont_numero": item["marcador_nome"],
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
      FFAppState().trSincroniza[index] = {
        "fazenda_id": fazId.toString(),
        "servico_id": oservid.toString(),
        "pontos": transformedList + transformedListInacessiveis,
      };
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
