import '/flutter_flow/flutter_flow_util.dart';
import 'fotoobserva_widget.dart' show FotoobservaWidget;
import 'package:flutter/material.dart';

class FotoobservaModel extends FlutterFlowModel<FotoobservaWidget> {
  ///  Local state fields for this component.

  int checked = 0;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
