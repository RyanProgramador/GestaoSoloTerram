import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'servico_inicio_widget.dart' show ServicoInicioWidget;
import 'package:flutter/material.dart';

class ServicoInicioModel extends FlutterFlowModel<ServicoInicioWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // Stores action output result for [Custom Action - checkinternet] action in Button widget.
  bool? temNet;
  // Stores action output result for [Backend Call - API (trPontos)] action in Button widget.
  ApiCallResponse? trPontos;

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
