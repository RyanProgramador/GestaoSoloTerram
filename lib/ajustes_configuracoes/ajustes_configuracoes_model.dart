import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'ajustes_configuracoes_widget.dart' show AjustesConfiguracoesWidget;
import 'package:flutter/material.dart';

class AjustesConfiguracoesModel
    extends FlutterFlowModel<AjustesConfiguracoesWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (tricones)] action in Button widget.
  ApiCallResponse? trIcones;

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
