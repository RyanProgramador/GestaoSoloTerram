// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<dynamic> atualizaListas(
  dynamic lista1,
  List<dynamic> lista2,
) async {
  // Lista para armazenar os pontos da lista2 que não existem na lista1
  List<Map<String, dynamic>> pontosNovos = [];

  // Itera pela lista2
  for (var ponto2 in lista2) {
    bool encontrado = false;

    // Verifica se o ponto2 já existe na lista1
    for (var ponto1 in lista1['pontos'].cast<Map<String, dynamic>>()) {
      if (ponto1['pont_id'] == ponto2['pont_id']) {
        // Atualiza os dados do ponto existente
        ponto1.addAll(ponto2);
        encontrado = true;
        break;
      }
    }

    // Se o ponto2 não existe na lista1, adiciona-o à lista pontosNovos
    if (!encontrado) {
      pontosNovos
          .add(ponto2 as Map<String, dynamic>); // Força a conversão para Map
    }
  }

  // Adiciona os pontosNovos à lista1
  lista1['pontos'].addAll(pontosNovos);

  // Retorna a lista1
  return lista1;
}
