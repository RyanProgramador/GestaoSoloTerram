import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'inicio_widget.dart' show InicioWidget;
import 'package:flutter/material.dart';

class InicioModel extends FlutterFlowModel<InicioWidget> {
  ///  Local state fields for this page.

  bool net = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - checkinternet] action in Inicio widget.
  bool? temInternet;
  // Stores action output result for [Backend Call - API (trOsServicos)] action in Inicio widget.
  ApiCallResponse? apiTrOsServicos;
  Completer<ApiCallResponse>? apiRequestCompleter;
  // Stores action output result for [Custom Action - checkinternet] action in Icon widget.
  bool? netcheck;
  // Stores action output result for [Custom Action - checkinternet] action in Icon widget.
  bool? netcheck2;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
