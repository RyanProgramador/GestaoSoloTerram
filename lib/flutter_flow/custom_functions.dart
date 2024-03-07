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
  dynamic listaJsonDoServico,
) {
//listaJsonDoServico = {
//   "fazenda_id":1,
//   "servico_id":1,
//   "pontos":[
//      {
//         "pont_id":17429,
//         "pont_numero":393,
//         "pont_latitude":"-17.780151593",
//         "pont_longitude":"-51.061255731",
//         "pont_simbolo":"Pin, Green",
//         "pont_status":1,
//         "pont_observacao":"",
//         "pont_foto":"",
//         "profundidades":[
//            {
//               "pprof_id":20319,
//               "pprof_status":1,
//               "pprof_icone":"Pin, Green",
//               "pprof_observacao":"",
//               "pprof_foto":"null",
//               "pprof_datahora":"2024-03-05 19:29"
//            },
//            {
//               "pprof_id":20320,
//               "pprof_status":1,
//               "pprof_icone":"Pin, Green",
//               "pprof_observacao":"",
//               "pprof_foto":"null",
//               "pprof_datahora":"2024-03-05 19:29"
//            }
//         ]
//      },
//	{
//         "pont_id":17429,
//         "pont_numero":394,
//         "pont_latitude":"-17.780151593",
//         "pont_longitude":"-51.061255731",
//         "pont_simbolo":"Pin, Green",
//         "pont_status":1,
//         "pont_observacao":"",
//         "pont_foto":"",
//         "profundidades":[
//            {
//               "pprof_id":20319,
//               "pprof_status":0,
//               "pprof_icone":"Pin, Green",
//               "pprof_observacao":"",
//               "pprof_foto":"null",
//               "pprof_datahora":"2024-03-05 19:29"
//            },
//            {
//               "pprof_id":20320,
//               "pprof_status":0,
//               "pprof_icone":"Pin, Green",
//               "pprof_observacao":"",
//               "pprof_foto":"null",
//               "pprof_datahora":"2024-03-05 19:29"
//            }
//         ]
//      }
//
//   ]
//}
//
//VERIFICA TABEM SE O pprofIDdoPonto NA listaJsonDoServico[pprof_id] O PPROF_STATUS É IGUAL A 0 OU 1, SE FOR 1 É COLETADO SE FOR 0 É NÃO COLETADO
//
//  bool isCollected = pontosColetados
//      .any((ponto) => ponto['profundidade'] == pprofIDdoPonto.toString());
//  if (isCollected) {
//    return "Coletado";
//  }
//
//  // Check if the point is inaccessible
//  bool isInaccessible = pontosInacessiveis
//      .any((ponto) => ponto['profundidade'] == pprofIDdoPonto.toString());
//  if (isInaccessible) {
//    return "Inacessível";
//  }
//
//  // If neither collected nor inaccessible, it's pending
//  return "Pendente";

  List<dynamic> pontosDoServico = listaJsonDoServico['pontos'];

  for (var item in pontosDoServico) {
    for (var profundidade in item['profundidades']) {
      // Verifica se o pprof_id está presente na profundidade
      if (profundidade['pprof_id'] == pprofIDdoPonto) {
        print(profundidade['pprof_id']);
        print(profundidade['pprof_status']);
        print(profundidade['pprof_foto']);
        // Retorna o status da profundidade
        if (profundidade['pprof_status'] == 1) {
          return "Coletado";
        } else if (profundidade['pprof_status'] == 2) {
          return "Inacessível";
        } else {
          // Verifica se o ponto foi coletado
          bool isCollected = pontosColetados.any(
              (ponto) => ponto['profundidade'] == pprofIDdoPonto.toString());

          // Se o ponto foi coletado, retorna "Coletado"
          if (isCollected) {
            return "Coletado";
          }

          // Verifica se o ponto é inacessível
          bool isInaccessible = pontosInacessiveis.any(
              (ponto) => ponto['profundidade'] == pprofIDdoPonto.toString());

          // Se o ponto é inacessível, retorna "Inacessível"
          if (isInaccessible) {
            return "Inacessível";
          }
          return "Pendente";
        }
      }
    }
  }

  // Verifica se o ponto foi coletado
  bool isCollected = pontosColetados
      .any((ponto) => ponto['profundidade'] == pprofIDdoPonto.toString());

  // Se o ponto foi coletado, retorna "Coletado"
  if (isCollected) {
    return "Coletado";
  }

  // Verifica se o ponto é inacessível
  bool isInaccessible = pontosInacessiveis
      .any((ponto) => ponto['profundidade'] == pprofIDdoPonto.toString());

  // Se o ponto é inacessível, retorna "Inacessível"
  if (isInaccessible) {
    return "Inacessível";
  }

  // Se o ponto não foi coletado nem é inacessível, é pendente
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

String? pesquisaFotoBas64HTML(
  String? pprofID,
  List<dynamic> pontosColetados,
  List<dynamic> pontosInacessivel,
  dynamic listaJsonDoServico,
) {
  // Função para verificar se o ponto possui foto na listaJsonDoServico
  String? fotoDoPonto(dynamic ponto) {
    if (ponto['profundidades'] is List) {
      for (var profundidade in ponto['profundidades']) {
        if (profundidade['pprof_id'].toString() == pprofID &&
            profundidade['pprof_foto'] != null &&
            profundidade['pprof_foto'] != '') {
          return profundidade['pprof_foto'];
        }
      }
    }
    return null;
  }

  // Verifica se o ponto possui foto na listaJsonDoServico
  String? fotoEncontrada = listaJsonDoServico['pontos'].fold(
      null, (previousValue, ponto) => previousValue ?? fotoDoPonto(ponto));

  // Se a foto foi encontrada, retorna
  if (fotoEncontrada != null) {
    return fotoEncontrada;
  }

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
        registro['fazenda_id'].toString() == fazid.toString() &&
        registro['servico_id'].toString() == oservid.toString(),
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
        registro['fazenda_id'].toString() == fazid.toString() &&
        registro['servico_id'].toString() == oservid.toString(),
  );

  /// Se o índice não for encontrado, retorna -1
  return indiceEncontrado == -1 ? null : indiceEncontrado;
}
