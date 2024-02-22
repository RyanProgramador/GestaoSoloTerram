import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'lista_pontos_widget.dart' show ListaPontosWidget;
import 'package:flutter/material.dart';

class ListaPontosModel extends FlutterFlowModel<ListaPontosWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (trTalhao)] action in Button widget.
  ApiCallResponse? trTalh;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
