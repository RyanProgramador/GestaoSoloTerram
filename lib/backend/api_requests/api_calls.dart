import 'dart:convert';
import 'dart:typed_data';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start trOsServicos Group Code

class TrOsServicosGroup {
  static String baseUrl = 'http';
  static Map<String, String> headers = {};
  static TrOsServicosCall trOsServicosCall = TrOsServicosCall();
}

class TrOsServicosCall {
  Future<ApiCallResponse> call({
    String? urlApi = '',
    String? tecnicoId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "tipo": "ff_busca_servicos",
  "tecnico_id": "${tecnicoId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'trOsServicos',
      apiUrl: '${TrOsServicosGroup.baseUrl}${urlApi}',
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
