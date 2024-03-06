import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/sqlite/sqlite_manager.dart';

LatLng? listaStrToListaLatLng(
  String? latitude,
  String? longitude,
) {
  if (latitude == null || longitude == null) return null;

  try {
    final double lat = double.parse(latitude);
    final double lng = double.parse(longitude);
    return LatLng(lat, lng);
  } catch (e) {
    // Em caso de erro na conversão, retorna null
    return null;
  }
}

int? contadorDeIntensNaLista(List<dynamic>? lista) {
  if (lista == null) {
    return 0;
  } else {
    return lista.length;
  }
}

String? retornalegenda(
  String? icoValorPesquisa,
  List<dynamic>? listaTrIcones,
) {
  final itemEncontrado = listaTrIcones?.firstWhere(
    (item) => item['ico_valor'] == icoValorPesquisa,
    orElse: () => null,
  );

  if (itemEncontrado != null) {
    return itemEncontrado['ico_legenda'];
  }
  return "erro"; // Retorna "erro" se nenhum item correspondente foi encontrado
}

String? latlngToString(LatLng? latlng) {
  if (latlng == null) return null;
  return "${latlng.latitude}, ${latlng.longitude}";
}

String? pesquisaParaVerSeOPontoFoiColetado(
  int? pprofIDdoPonto,
  List<dynamic> pontosColetados,
  List<dynamic> pontosInacessiveis,
) {
  bool isCollected = pontosColetados
      .any((ponto) => ponto['profundidade'] == pprofIDdoPonto.toString());
  if (isCollected) {
    return "Coletado";
  }

  // Check if the point is inaccessible
  bool isInaccessible = pontosInacessiveis
      .any((ponto) => ponto['profundidade'] == pprofIDdoPonto.toString());
  if (isInaccessible) {
    return "Inacessível";
  }

  // If neither collected nor inaccessible, it's pending
  return "Pendente";
}

String? pesquisaFotoBas64(
  String? pprofID,
  List<dynamic> pontosColetados,
  List<dynamic> pontosInacessivel,
) {
  // Attempt to find a collected point with the matching profundidade
  var collectedPoint = pontosColetados.firstWhere(
    (ponto) => ponto['profundidade'].toString() == pprofID,
    orElse: () => null,
  );

  if (collectedPoint != null) {
    return collectedPoint['foto'];
  }

  // Attempt to find an inaccessible point with the matching profundidade
  var inaccessiblePoint = pontosInacessivel.firstWhere(
    (ponto) => ponto['profundidade'].toString() == pprofID,
    orElse: () => null,
  );

  if (inaccessiblePoint != null) {
    return inaccessiblePoint['foto'];
  }

  // If neither collected nor inaccessible, it's pending or an error
  return "Pending or Error"; // Adjust this return value based on your needs
}

bool? pesquisaOservEFazIdNoTrSinc(
  String? oservID,
  String? fazid,
  List<dynamic> trSincronizaPos,
) {
  return trSincronizaPos.any((e) =>
      e['fazenda_id'].toString() == fazid &&
      e['servico_id'].toString() == oservID);
}

dynamic buscaRegistro(
  int fazid,
  int oservid,
  List<dynamic> trSinc,
) {
  var registroEncontrado = trSinc.firstWhere(
    (registro) =>
        registro['fazenda_id'].toString() == fazid &&
        registro['servico_id'].toString() == oservid,
    orElse: () =>
        null, // Retorna null se nenhum registro correspondente for encontrado
  );

  return registroEncontrado;
}

String? quantosPontosFaltamParaColetar(
  String? oservId,
  String? fazId,
  String? aColetar,
  List<dynamic> pontosTotalmenteColetados,
) {
  int registros = pontosTotalmenteColetados
      .where((element) =>
          element['oserv_id'].toString() == oservId &&
          element['faz_id'].toString() == fazId)
      .length;

  // Converte aColetar de String para int para realizar a operação
  int aColetarInt = int.tryParse(aColetar ?? "0") ?? 0;

  // Calcula quantas coletas faltam e converte o resultado para String
  int faltam = aColetarInt - registros;

  // Considerando que você pode querer retornar um valor positivo caso o cálculo resulte em negativo
  faltam = faltam < 0 ? 0 : faltam;

  return faltam.toString();
}

String? protocoloComSeguranca(String? urL) {
  if (urL != null) {
    urL = urL.replaceAll("http", ""); // Remove "http://"
  }

  return urL;
}

int? buscaRegistroIndex(
  int fazid,
  int oservid,
  List<dynamic> trSinc,
) {
  var indiceEncontrado = trSinc.indexWhere(
    (registro) =>
        registro['fazenda_id'].toString() == fazid &&
        registro['servico_id'].toString() == oservid,
  );

  /// Se o índice não for encontrado, retorna -1
  return indiceEncontrado == -1 ? null : indiceEncontrado;
}
