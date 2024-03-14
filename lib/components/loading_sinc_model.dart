import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'loading_sinc_widget.dart' show LoadingSincWidget;
import 'package:flutter/material.dart';

class LoadingSincModel extends FlutterFlowModel<LoadingSincWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - tSincronizaApenasQueAindaNaoFOramSincronizadosAnteriormente] action in LoadingSinc widget.
  dynamic trSincSoComS;
  // Stores action output result for [Backend Call - API (trSincronizaPontosColetados)] action in LoadingSinc widget.
  ApiCallResponse? trSinc;
  // Stores action output result for [Backend Call - API (trPontos)] action in LoadingSinc widget.
  ApiCallResponse? trPontos;
  // Stores action output result for [Backend Call - API (trTalhao)] action in LoadingSinc widget.
  ApiCallResponse? trTalhaoDoServico;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
