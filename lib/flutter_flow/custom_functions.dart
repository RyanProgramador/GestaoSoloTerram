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

bool? buscaSeAEtapaEstaIniciadaENaoFinalizada(dynamic trSinc) {
  if (trSinc['etapas'] != null && trSinc['etapas'].isNotEmpty) {
    bool todasEtapasFinalizadas = true;
    for (var etapa in trSinc['etapas']) {
      if (etapa['etap_fim'] == null || etapa['etap_fim'].isEmpty) {
        todasEtapasFinalizadas = false;
        break; // Encerra o loop se encontrar alguma etapa não finalizada
      }
    }
    return todasEtapasFinalizadas;
  }
  return false;
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

String? buscalegendaiconeAtravesDaEtiquetaEmPontosCopy(
  dynamic trSinc,
  String? etiquetaNum,
  int? fazId,
  int? oservId,
) {
  List<dynamic> trSincComS = trSinc['pontos'];

  List<dynamic> profundidadesNaoSincronizadas = [];
  for (var profIcon in trSincComS) {
    var legendaIcone = profIcon['profundidades'] as List<dynamic>;
    var legendaIconeFiltrada = legendaIcone
        .where((legendaIcone) =>
            legendaIcone['sincronizado'].toString() == "S" &&
            legendaIcone['pprof_etiqueta_id'].toString() == etiquetaNum)
        .map((e) => e['pprof_icone'])
        .toList();

    profundidadesNaoSincronizadas.addAll(legendaIconeFiltrada);
  }
  return profundidadesNaoSincronizadas.first.toString();
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
  return null; // Adjust this return value based on your needs
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

String? pontosASemreColetadosTrSinc(
  String? oservid,
  String? fazid,
  List<dynamic> trSinc,
) {
  List<dynamic> lista = trSinc
      .where((element) =>
          element['fazenda_id'] == int.parse(fazid!) &&
          element['servico_id'] == int.parse(oservid!))
      .map((e) => e["pontos"])
      .toList()
      .first;
  var listaSemiFiltrada = lista;

  return lista
      .where((element) => element['pont_status'] != 0)
      .length
      .toString();
}

bool? indentificahtml(String? string) {
  if (string != null) {
    // Check for valid HTTP or HTTPS URL
    if (string.startsWith('http://') || string.startsWith('https://')) {
      return true; // Return the URL directly
    } else {
      // Attempt to decode base64 (handle potential errors)
      try {
        // Decode the base64 string
        base64Decode(string);
        // If decoding is successful, return the data URI with PNG format
        return false;
      } on FormatException {
        // Handle potential base64 decoding errors gracefully
        print('Error: Invalid base64 string provided.');
        return null; // Or return a specific error message if desired
      }
    }
  } else {
    // Handle null input string
    print('Error: Input string is null.');
    return null;
  }
}

String? convertStringToImagemPAth(String? string) {
  return string;
}

dynamic adcionaEtapaAoJson(dynamic trSinc) {
  trSinc['etapas'] ??= [];
  String formatDateTime(String dateTimeStr) {
    // Cria um objeto DateTime a partir da string
    DateTime dateTime = DateTime.parse(dateTimeStr);
    // Cria um formatador com o padrão desejado
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    // Retorna a string formatada
    return formatter.format(dateTime);
  }

  int etapId =
      trSinc['etapas'].isEmpty ? 1 : trSinc['etapas'].last['etap_id'] + 1;

  // Verifica se a última etapa foi concluída
  if (trSinc['etapas'].isNotEmpty &&
      (trSinc['etapas'].last['etap_fim'] == null ||
          trSinc['etapas'].last['etap_fim'].isEmpty)) {
    print("Parece que a última etapa ainda não foi finalizada!");
    // Atualiza a última etapa para finalizá-la
    trSinc['etapas'].last['etap_fim'] =
        formatDateTime(DateTime.now().toString());
  } else {
    // Adiciona uma nova etapa
    Map<String, dynamic> novaEtapa = {
      "etap_id": etapId,
      "etap_status": 1,
      "etap_inicio": formatDateTime(DateTime.now().toString()),
      "etap_fim": "", // Deixe vazio inicialmente
      "pontos": [],
      "volumes": [],
    };
    trSinc['etapas'].add(novaEtapa);
  }

  return trSinc;
}

bool? buscaSeAEtapaEstaIniciada(dynamic trSinc) {
  if (trSinc['etapas'] != null && trSinc['etapas'].isNotEmpty) {
    // Procura por uma etapa que esteja iniciada, mas não finalizada
    for (var etapa in trSinc['etapas']) {
      if (etapa['etap_fim'] == null || etapa['etap_fim'].isEmpty) {
        return true; // Retorna true se encontrar uma etapa não finalizada
      }
    }
  }
  return false;
}

List<String> buscaVolumesNoRegistro(dynamic trSinc) {
  List<String> amostrasList = [];
  List<String> etapaList = [];
  if (trSinc['etapas'] != null && trSinc['etapas'].isNotEmpty) {
    for (var etapa in trSinc['etapas']) {
      if (etapa['etap_fim'] == null || etapa['etap_fim'].isEmpty) {
        if (etapa['volumes'] != null && etapa['volumes'].isNotEmpty) {
          for (var volume in etapa['volumes']) {
            if (volume['volume_data_hora_fim'] == null ||
                volume['volume_data_hora_fim'].isEmpty) {
              // Se existem amostras no volume não finalizado, adiciona à lista
              if (volume['amostras'] != null && volume['amostras'].isNotEmpty) {
                // Extende a lista de amostrasNaoFinalizadas com as amostras do volume não finalizado
                amostrasList.addAll(List<String>.from(volume['amostras']));
              }
            }
          }
        }
      }
    }
  }

  return amostrasList;
}

String? buscaPontoAtravesDaEtiquetaEmPontos(
  dynamic trSinc,
  String? etiquetaNum,
  int? fazId,
  int? oservId,
) {
  List<dynamic> pontosFiltrados = trSinc['pontos'];

  for (var ponto in pontosFiltrados) {
    if (ponto['profundidades'] != null) {
      for (var profundidade in ponto['profundidades']) {
        if (profundidade['pprof_etiqueta_id'].toString() == etiquetaNum &&
            profundidade['sincronizado'] == 'S') {
          return ponto['pont_numero'].toString();
        }
      }
    }
  }
  // return pontosEncontrados.isNotEmpty ? pontosEncontrados.first : null;
  return 'error#buscaPontoAtravesDaEtiquetaEmPontos';
}

List<dynamic>? buscaListaDeVolumes(dynamic trSinc) {
  List<dynamic> listaDeVolumes = [];
  if (trSinc['etapas'] != null && trSinc['etapas'].isNotEmpty) {
    for (var etapa in trSinc['etapas']) {
      if (etapa['etap_fim'] == null || etapa['etap_fim'].isEmpty) {
        if (etapa['volumes'] != null && etapa['volumes'].isNotEmpty) {
          listaDeVolumes.addAll(etapa['volumes']);
        }
      }
    }
  }
  return listaDeVolumes.isNotEmpty ? listaDeVolumes : null;
}

String? contadorDeNumeroDeAmostras(
  dynamic trSinc,
  String? idDoVolume,
) {
// acessar dados.etapas.volumes.amostras
/*
{
      "fazenda_id":1,
      "servico_id":1,
      "pontos":[],
      "etapas":[
         {
            "etap_id":1,
            "etap_status":1,
            "etap_inicio":"2024-03-19 13:18",
            "etap_fim":"2024-03-20 12:04",
            "pontos":[
               "29732",
               "29709",
               "29672",
               "29673",
               "29736"
            ],
            "volumes":[
               {
                  "volume_id":1,
                  "foto":"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",
                  "volume_data_hora_inicio":"2024-03-19T13:18:35.474807",
                  "volume_data_hora_fim":"2024-03-20 12:04",
                  "lacre":"-1",
                  "amostras":[
                     "777",
                     "778",
                     "780"
                  ],
                  "sincronizado":"N"
               }
            ]
         }
      ],
      "etiquetas":[
         "777",
         "778",
         "780",
         "781",
         "782"
      ]
   }
   */

//trSinc['etapas'] <------ inicio
  return "teste";
}
