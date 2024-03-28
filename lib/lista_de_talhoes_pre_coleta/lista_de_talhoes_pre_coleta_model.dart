import '/flutter_flow/flutter_flow_util.dart';
import 'lista_de_talhoes_pre_coleta_widget.dart'
    show ListaDeTalhoesPreColetaWidget;
import 'package:flutter/material.dart';

class ListaDeTalhoesPreColetaModel
    extends FlutterFlowModel<ListaDeTalhoesPreColetaWidget> {
  ///  Local state fields for this page.

  dynamic emptystring;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for Checkbox widget.

  Map<dynamic, bool> checkboxValueMap2 = {};
  List<dynamic> get checkboxCheckedItems2 => checkboxValueMap2.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

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
