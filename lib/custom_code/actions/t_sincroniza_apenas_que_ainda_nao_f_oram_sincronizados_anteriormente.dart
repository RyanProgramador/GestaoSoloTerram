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

Future<dynamic> tSincronizaApenasQueAindaNaoFOramSincronizadosAnteriormente(
    dynamic trSinc) async {
  // Add your function code here!
//List<dynamic> trSincComS = trSinc
//        .map((e) => e["pontos"])
//        .toList()
//        .first;
//
//   List<dynamic> trSincTudoJunto = [];
//    for (var item in trSincComS) {
//      // Verifica se o item tem a chave 'profundidades' e se é uma lista
//      if (item.containsKey('profundidades') && item['profundidades'] is List) {
//        // Filtra as profundidades onde 'sincronizado' é diferente de "N"
//        var profundidadesFiltradas = item['profundidades']
//            .where((profundidade) => profundidade['sincronizado'] != "N")
//            .toList();
//
//        // Se profundidadesFiltradas não está vazia, adicione o item a trSincTudoJunto
//        if (profundidadesFiltradas.isNotEmpty) {
//          // Aqui você pode decidir se quer adicionar o item inteiro ou apenas as profundidades filtradas
//          trSincTudoJunto.add(item); // Adiciona o item inteiro
//          // Se quiser adicionar apenas as profundidades filtradas, use a linha abaixo
//          // trSincTudoJunto.addAll(profundidadesFiltradas);
//        }
//      }
//    }
//trSinc['pontos'] = trSincTudoJunto;
//
//    return trSinc;

  List<dynamic> pontosFiltrados = [];

  // Iterando sobre a lista de pontos em trSinc
  for (var ponto in trSinc['pontos']) {
    // Filtrando as profundidades onde 'sincronizado' é igual a "S"
    var profundidadesFiltradas = ponto['profundidades']
        .where((profundidade) => profundidade['sincronizado'] == "S")
        .toList();

    // Se profundidadesFiltradas não está vazia, adicione o ponto com as profundidades filtradas
    if (profundidadesFiltradas.isNotEmpty) {
      ponto['profundidades'] =
          profundidadesFiltradas; // Atualiza a lista de profundidades do ponto
      pontosFiltrados.add(
          ponto); // Adiciona o ponto atualizado à lista de pontos filtrados
    }
  }

  // Atualizando 'pontos' em trSinc com a lista filtrada
  trSinc['pontos'] = pontosFiltrados;

  return trSinc;
}
