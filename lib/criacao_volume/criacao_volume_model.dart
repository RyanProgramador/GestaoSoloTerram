import '/flutter_flow/flutter_flow_util.dart';
import 'criacao_volume_widget.dart' show CriacaoVolumeWidget;
import 'package:flutter/material.dart';

class CriacaoVolumeModel extends FlutterFlowModel<CriacaoVolumeWidget> {
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
