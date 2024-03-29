import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'login_widget.dart' show LoginWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginModel extends FlutterFlowModel<LoginWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - lembrarSenha] action in Login widget.
  bool? simna;
  // Stores action output result for [Custom Action - md5encode] action in Login widget.
  String? md5Passs2;
  // Stores action output result for [Backend Call - API (trLogin)] action in Login widget.
  ApiCallResponse? trLogin2;
  // Stores action output result for [Backend Call - API (tricones)] action in Login widget.
  ApiCallResponse? trIcones2;
  // State field(s) for emailAddress_Login widget.
  FocusNode? emailAddressLoginFocusNode;
  TextEditingController? emailAddressLoginController;
  final emailAddressLoginMask = MaskTextInputFormatter(mask: '###.###.###-##');
  String? Function(BuildContext, String?)? emailAddressLoginControllerValidator;
  // State field(s) for password_Login widget.
  FocusNode? passwordLoginFocusNode;
  TextEditingController? passwordLoginController;
  late bool passwordLoginVisibility;
  String? Function(BuildContext, String?)? passwordLoginControllerValidator;
  // Stores action output result for [Custom Action - md5encode] action in Container widget.
  String? md5Passs;
  // Stores action output result for [Backend Call - API (trLogin)] action in Container widget.
  ApiCallResponse? trLogin;
  // Stores action output result for [Backend Call - API (tricones)] action in Container widget.
  ApiCallResponse? trIcones;
  // Stores action output result for [Backend Call - API (pegaParametros)] action in Container widget.
  ApiCallResponse? resultadPegaParametros;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    passwordLoginVisibility = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    emailAddressLoginFocusNode?.dispose();
    emailAddressLoginController?.dispose();

    passwordLoginFocusNode?.dispose();
    passwordLoginController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
