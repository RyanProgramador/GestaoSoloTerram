import 'dart:convert';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start trOsServicos Group Code

class TrOsServicosGroup {
  static String baseUrl = 'http';
  static Map<String, String> headers = {};
  static TrOsServicosCall trOsServicosCall = TrOsServicosCall();
  static TriconesCall triconesCall = TriconesCall();
  static TrPontosCall trPontosCall = TrPontosCall();
  static TrTalhaoCall trTalhaoCall = TrTalhaoCall();
  static TrSincronizaPontosColetadosCall trSincronizaPontosColetadosCall =
      TrSincronizaPontosColetadosCall();
  static TrLoginCall trLoginCall = TrLoginCall();
  static TrEsqueciCall trEsqueciCall = TrEsqueciCall();
}

class TrOsServicosCall {
  Future<ApiCallResponse> call({
    String? urlApi = '',
    String? tecnicoId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "tipo": "ff_busca_servicos",
  "tecnico_id": "$tecnicoId"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'trOsServicos',
      apiUrl: '${TrOsServicosGroup.baseUrl}$urlApi',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  bool? statusTrBuscaOsServicos(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  List? dadosTrBuscaOsServicos(dynamic response) => getJsonField(
        response,
        r'''$.dados''',
        true,
      ) as List?;
}

class TriconesCall {
  Future<ApiCallResponse> call({
    String? urlApi = '',
  }) async {
    const ffApiRequestBody = '''
{
  "tipo": "ff_busca_icones"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'tricones',
      apiUrl: '${TrOsServicosGroup.baseUrl}$urlApi',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  bool? statusTrBuscaIcones(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  List? dadosTrBuscaIcones(dynamic response) => getJsonField(
        response,
        r'''$.dados''',
        true,
      ) as List?;
}

class TrPontosCall {
  Future<ApiCallResponse> call({
    String? urlApi = '',
    int? servicoId,
    int? fazendaId,
  }) async {
    final ffApiRequestBody = '''
{
  "tipo": "ff_busca_pontos",
  "servico_id": "$servicoId",
"fazenda_id":"$fazendaId"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'trPontos',
      apiUrl: '${TrOsServicosGroup.baseUrl}$urlApi',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  bool? statusTrBuscaPontos(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.status''',
      ));
  List? dadosTrBuscaPontos(dynamic response) => getJsonField(
        response,
        r'''$.dados''',
        true,
      ) as List?;
  List<int>? dadosPontos(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].ponto''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? dadosProfundidades(dynamic response) => getJsonField(
        response,
        r'''$.dados[:].profundidades''',
        true,
      ) as List?;
  List<String>? dadosProfIco(dynamic response) => (getJsonField(
        response,
        r'''$.dados[:].profundidades[:].ico_valor''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class TrTalhaoCall {
  Future<ApiCallResponse> call({
    String? urlApi = '',
    int? fazId,
  }) async {
    final ffApiRequestBody = '''
{ 
    "tipo":"ff_busca_contornos",
    "fazenda_id":"$fazId"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'trTalhao',
      apiUrl: '${TrOsServicosGroup.baseUrl}$urlApi',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class TrSincronizaPontosColetadosCall {
  Future<ApiCallResponse> call({
    String? urlApi = '',
    dynamic pontosJson,
  }) async {
    final pontos = _serializeJson(pontosJson);
    final ffApiRequestBody = '''
{
  "tipo": "ff_sincroniza_coletas",
  "dados": $pontos
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'trSincronizaPontosColetados',
      apiUrl: '${TrOsServicosGroup.baseUrl}$urlApi',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class TrLoginCall {
  Future<ApiCallResponse> call({
    String? urlApi = '',
    String? senha = '',
    String? usuario = '',
  }) async {
    final ffApiRequestBody = '''
{"tipo": "ff_valida_acesso",
"usuario":"$usuario",
"senha":"$senha"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'trLogin',
      apiUrl: '${TrOsServicosGroup.baseUrl}$urlApi',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class TrEsqueciCall {
  Future<ApiCallResponse> call({
    String? urlApi = '',
    String? senha = '',
    String? usuario = '',
  }) async {
    final ffApiRequestBody = '''
{"tipo": "ff_recupera_senha",
"usuario":"$usuario"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'trEsqueci',
      apiUrl: '${TrOsServicosGroup.baseUrl}$urlApi',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

/// End trOsServicos Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
