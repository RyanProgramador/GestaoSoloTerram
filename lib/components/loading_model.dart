import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'loading_widget.dart' show LoadingWidget;
import 'package:flutter/material.dart';

class LoadingModel extends FlutterFlowModel<LoadingWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - checkinternet] action in Loading widget.
  bool? temNet;
  // Stores action output result for [Backend Call - API (trPontos)] action in Loading widget.
  ApiCallResponse? trPontos;
  // Stores action output result for [Backend Call - API (trTalhao)] action in Loading widget.
  ApiCallResponse? trTalhaoDoServico;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
