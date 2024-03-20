import '/flutter_flow/flutter_flow_util.dart';
import 'listade_amostras_widget.dart' show ListadeAmostrasWidget;
import 'package:flutter/material.dart';

class ListadeAmostrasModel extends FlutterFlowModel<ListadeAmostrasWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - excluiVolumeDaEtapaAberta] action in Icon widget.
  String? retornoEclusao;

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
