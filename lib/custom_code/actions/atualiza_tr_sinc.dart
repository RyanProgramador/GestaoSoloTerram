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
  // String formatDateTime(String dateTimeStr) {
  //   DateTime dateTime = DateTime.parse(dateTimeStr);
  //   DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  //   return formatter.format(dateTime);
  // }
  //
  // var lista = FFAppState().PontosColetados.where((element) =>
  // element['oserv_id'] == oservid.toString() &&
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
  //       .map((item) =>
  //   {
  //     "pprof_id": int.parse(item["profundidade"]),
  //     "pprof_status": "1",
  //     "pprof_icone": item['profundidade'],
  //     "pprof_observacao": item["obs"].toString() ?? "Sem observação!",
  //     "pprof_foto": item["foto"].toString() ?? "",
  //     "pprof_datahora": formatDateTime(item["data_hora"].toString()),
  //   })
  //       .toList();
  //
  //   transformedList.add({
  //     "pont_id": idPonto,
  //     "pont_numero": items.first["marcador_nome"],
  //     "pont_latitude": "",
  //     "pont_longitude": "",
  //     "pont_simbolo": "Pin, Green",
  //     "pont_status": "1",
  //     "pont_observacao": "",
  //     "pont_foto": "",
  //     "profundidades": profundidades,
  //   });
  // });
  //
  // var listaIna = FFAppState().PontosInacessiveis.where((element) =>
  // element['oserv_id'] == oservid.toString() &&
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
  //     var profundidades = items
  //         .map((item) =>
  //     {
  //       "pprof_id": item["profundidade"],
  //       "pprof_status": "2",
  //       "pprof_icone": item['profundidade'],
  //       "pprof_observacao": "",
  //       "pprof_foto": "",
  //       "pprof_datahora": formatDateTime(item["data_hora"].toString()),
  //     })
  //         .toList();
  //
  //     transformedListInacessiveis.add({
  //       "pont_id": idPonto,
  //       "pont_numero": items.first["marcador_nome"],
  //       "pont_latitude": "",
  //       "pont_longitude": "",
  //       "pont_simbolo": "",
  //       "pont_status": "2",
  //       "pont_observacao": items.first["obs"].toString(),
  //       "pont_foto": items.first["foto"].toString(),
  //       "profundidades": profundidades,
  //     });
  //   }
  // });
  // var jaExisteTrSincroniza = FFAppState()
  //     .trSincroniza
  //     .where((element) =>
  // element['fazenda_id'] == fazId.toString() &&
  //     element['servico_id'] == oservid.toString())
  //     .toList();
  //
  // // 7. Check if synchronized data exists
  // if (jaExisteTrSincroniza.isNotEmpty) {
  //   // 7.1 Update existing synchronized data (assuming you want to replace all points)
  //   int index = FFAppState().trSincroniza.indexOf(jaExisteTrSincroniza.first);
  //   if (index != -1) {
  //     FFAppState().trSincroniza[index] = {
  //       "fazenda_id": fazId.toString(),
  //       "servico_id": oservid.toString(),
  //       "pontos": transformedList + transformedListInacessiveis,
  //     };
  //   }
  // } else {
  //   // 7.2 Add new synchronized data
  //   FFAppState().trSincroniza.add({
  //     "fazenda_id": fazId.toString(),
  //     "servico_id": oservid.toString(),
  //     "pontos": transformedList + transformedListInacessiveis,
  //   });
  // }

  String formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(dateTime);
  }

  // 1. Filter collected points for the specific service and farm
  var lista = FFAppState().PontosColetados.where((element) =>
      element['oserv_id'] == oservid.toString() &&
      element['faz_id'] == fazId.toString());

  // 2. Group points by ID for efficient processing
  Map<int, List<Map<String, dynamic>>> groupedByPontoId = {};
  for (var item in lista) {
    int idPonto = int.parse(item["id_ponto"]);
    if (!groupedByPontoId.containsKey(idPonto)) {
      groupedByPontoId[idPonto] = [];
    }
    groupedByPontoId[idPonto]!.add(item);
  }

  // 3. Prepare lists for transformed collected and inaccessible points
  List<Map<String, dynamic>> updatedPoints = []; // Stores updated points

  // 4. Process collected points
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

    // Find the corresponding point in synchronized data (if it exists)
    var existingPoint = FFAppState().trSincroniza.firstWhere(
        (element) => element['pont_id'] == idPonto,
        orElse: () => null);

    if (existingPoint != null) {
      // Update existing point with collected data
      existingPoint["profundidades"] = profundidades;
    } else {
      // Add new point if not found in synchronized data
      updatedPoints.add({
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
    }
  });

  // 5. Process inaccessible points (similar logic)
  var listaIna = FFAppState().PontosInacessiveis.where((element) =>
      element['oserv_id'] == oservid.toString() &&
      element['faz_id'] == fazId.toString());

  // Declare groupedByPontoIdInacessivel here to make it accessible within this section
  Map<int, List<Map<String, dynamic>>> groupedByPontoIdInacessivel = {};
  for (var item in listaIna) {
    int idPonto = int.parse(item["id_ponto"]);
    if (!groupedByPontoIdInacessivel.containsKey(idPonto)) {
      groupedByPontoIdInacessivel[idPonto] = [];
    }
    groupedByPontoIdInacessivel[idPonto]!.add(item);
  }

  for (var idPonto in groupedByPontoIdInacessivel.keys) {
    var items = groupedByPontoIdInacessivel[idPonto]!;
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

    var existingPoint = FFAppState().trSincroniza.firstWhere(
        (element) => element['pont_id'] == idPonto,
        orElse: () => null);

    if (existingPoint != null) {
      // Update existing point with inaccessible data (assuming no other changes)
      existingPoint["profundidades"] = profundidades;
      existingPoint["pont_status"] = 2; // Set status to inaccessible
    } else {
      // Add new inaccessible point if not found in synchronized data
      updatedPoints.add({
        "pont_id": idPonto,
        "pont_numero": items.first["marcador_nome"],
        "pont_latitude": "",
        "pont_longitude": "",
        "pont_simbolo": "", // Set appropriate symbol for inaccessible point
        "pont_status": 2,
        "pont_observacao": items.first["obs"].toString() ?? "",
        "pont_foto": items.first["foto"].toString() ?? "",
        "profundidades": profundidades,
      });
    }
  }

  // 6. Update synchronized data (if any points were updated)
  if (updatedPoints.isNotEmpty) {
    for (var point in updatedPoints) {
      // Find the index of the point in synchronized data (if it exists)
      int index = FFAppState()
          .trSincroniza
          .indexWhere((element) => element['pont_id'] == point['pont_id']);
      if (index != -1) {
        // Update the point in synchronized data
        FFAppState().trSincroniza[index] = point;
      } else {
        // This shouldn't happen, but handle it if necessary (e.g., log an error)
      }
    }
  }
}
