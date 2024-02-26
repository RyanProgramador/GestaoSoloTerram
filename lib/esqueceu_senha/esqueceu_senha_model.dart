import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'esqueceu_senha_widget.dart' show EsqueceuSenhaWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EsqueceuSenhaModel extends FlutterFlowModel<EsqueceuSenhaWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for emailAddress_Login widget.
  FocusNode? emailAddressLoginFocusNode;
  TextEditingController? emailAddressLoginController;
  final emailAddressLoginMask = MaskTextInputFormatter(mask: '###.###.###-##');
  String? Function(BuildContext, String?)? emailAddressLoginControllerValidator;
  // Stores action output result for [Backend Call - API (trEsqueci)] action in Container widget.
  ApiCallResponse? trEsquec;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    emailAddressLoginFocusNode?.dispose();
    emailAddressLoginController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
