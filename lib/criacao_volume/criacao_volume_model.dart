import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'criacao_volume_widget.dart' show CriacaoVolumeWidget;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';

class CriacaoVolumeModel extends FlutterFlowModel<CriacaoVolumeWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - excluiVolumeDaEtapaAberta] action in Icon widget.
  String? retornoEclusao;
  // State field(s) for Timer widget.
  int timerMilliseconds = 1000;
  String timerValue = StopWatchTimer.getDisplayTime(
    1000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  var qrCode = '';
  // Stores action output result for [Custom Action - buscaSeOVolumeEstaIniciadoEFinalizaEle] action in FloatingActionButton widget.
  bool? finalizacaoDeVolume;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    timerController.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
