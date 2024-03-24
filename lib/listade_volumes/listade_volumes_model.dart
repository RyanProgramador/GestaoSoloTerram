import '/flutter_flow/flutter_flow_util.dart';
import 'listade_volumes_widget.dart' show ListadeVolumesWidget;
import 'package:flutter/material.dart';

class ListadeVolumesModel extends FlutterFlowModel<ListadeVolumesWidget> {
  ///  Local state fields for this page.

  dynamic emptystring;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - buscaSeOVolumePrecisaSerFinalizado] action in Button widget.
  bool? buscaSeOVolumePrecisaSerFinaliz;
  // Stores action output result for [Custom Action - buscaSeOVolumeEstaIniciadoENaoFinalizado] action in Button widget.
  bool? buscaOVolumeIniciado;

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
