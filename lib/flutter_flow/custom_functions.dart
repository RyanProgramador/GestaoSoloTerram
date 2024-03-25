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
                for (var amostra in volume['amostras']) {
                  // Certifique-se de que amostra é um Map e volam_etiqueta_id é uma chave válida
                  if (amostra is Map &&
                      amostra.containsKey('volam_etiqueta_id')) {
                    // Adicione diretamente a String à lista
                    amostrasList.add(amostra['volam_etiqueta_id'].toString());
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  return amostrasList.reversed.toList();
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

String? contadorDeNumeroDeAmostras(String? stringDasAmostras) {
  if (stringDasAmostras == null ||
      stringDasAmostras == "" ||
      stringDasAmostras.isEmpty) {
    return "0";
  } else {
    //var stringExemplo = "1,2,3,4";
    List<String> numero = stringDasAmostras!.split(',');
    if (numero.first == null || numero.first == "null" || numero.first == "") {
      return "0";
    } else {
      return numero.length.toString();
    }
  }
  return "0";
}

List<String> listaStringParaListaString(String? stringDasAmostras) {
  List<String> numero = stringDasAmostras!.split(',');
  List<String> resultado = numero.map((e) => e.trim()).toList();
  return resultado;
}

String? diferencaEntreDatas(
  String? data1,
  String? data2,
) {
  // Parse the date strings to DateTime objects
  DateTime start = DateTime.parse(data1!);
  DateTime end = DateTime.parse(data2!);

  // Calculate the difference between the dates
  Duration diff = end.difference(start);

  // Convert the difference to hours and minutes
  int hours = diff.inHours;
  int minutes = diff.inMinutes % 60;

  // Format the difference as "1h30min"
  return "${hours}h ${minutes}min";
}

String? formatardatahora(String? datahora) {
  DateTime parsedData = DateFormat('yyyy-MM-dd HH:mm').parse(datahora!);
  String dataFormatada = DateFormat('dd/MM/yyyy HH:mm').format(parsedData);
  return dataFormatada;
}

String? buscapprofidAtravesDaEtiquetaEmPontos(
  dynamic trSinc,
  String? etiquetaNum,
) {
  List<dynamic> trSincComS = trSinc['pontos'];

  List<dynamic> profundidadesNaoSincronizadas = [];
  for (var profIcon in trSincComS) {
    var legendaIcone = profIcon['profundidades'] as List<dynamic>;
    var legendaIconeFiltrada = legendaIcone
        .where((legendaIcone) =>
            legendaIcone['sincronizado'].toString() == "S" &&
            legendaIcone['pprof_etiqueta_id'].toString() == etiquetaNum)
        .map((e) => e['pprof_id'])
        .toList();

    profundidadesNaoSincronizadas.addAll(legendaIconeFiltrada);
  }
  return profundidadesNaoSincronizadas.first.toString();
}

List<String> inverterLista(List<String> lista) {
  return lista.reversed.toList();
}

bool? verificaSeQrCodeJaFoiLidoOuNao(
  dynamic trSinc,
  String? etiquetaLida,
) {
  List<dynamic> volumesLacres = [];
  if (trSinc['etiquetas'] != null &&
      trSinc['etiquetas'].contains(etiquetaLida)) {
    return true;
  }
  if (trSinc['etapas'] != null) {
    for (var etapa in trSinc['etapas']) {
      if (etapa['volumes'] != null) {
        for (var volume in etapa['volumes']) {
          if (volume['lacre'] != null &&
              volume['lacre'].contains(etiquetaLida)) {
            return true;
          }
        }
      }
    }
  }
  return false;
}

List<dynamic>? listaPaginacao(
  List<dynamic>? listaInteiraDeTodosOsItens,
  int? paginaIndex,
) {
  if (listaInteiraDeTodosOsItens == null || paginaIndex == null) {
    return null;
  }

  /// Cálculo de páginas e itens por página
  final int totalPaginas = (listaInteiraDeTodosOsItens.length / 3).ceil();
  final int itensPorPagina = 3;

  /// Validação do índice da página
  if (paginaIndex < 0 || paginaIndex >= totalPaginas) {
    return null;
  }

  /// Cálculo do índice inicial e final dos itens da página
  final int indiceInicial = paginaIndex * itensPorPagina;
  final int indiceFinal = indiceInicial + itensPorPagina;

  /// Retorno da página com itens
  return [
    {
      "pagina": paginaIndex,
      "itens": listaInteiraDeTodosOsItens.sublist(indiceInicial, indiceFinal),
    },
  ];
}
