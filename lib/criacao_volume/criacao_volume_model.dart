import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'criacao_volume_widget.dart' show CriacaoVolumeWidget;
import 'dart:async';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';

class CriacaoVolumeModel extends FlutterFlowModel<CriacaoVolumeWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  Completer<ApiCallResponse>? apiRequestCompleter;
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

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    timerController.dispose();
  }

  /// Action blocks are added here.

  Future finalizaOVolume(
    BuildContext context, {
    required int? fazId,
    required int? oservId,
  }) async {
    String? qrCode;
    bool? finalizacaoDeVolume;

    qrCode = await actions.leitorDeQrCode(
      context,
    );
    if (functions.verificaSeQrCodeJaFoiLidoOuNao(
            functions.buscaRegistro(
                fazId!, oservId!, FFAppState().trSincroniza.toList()),
            qrCode) ==
        false) {
      await showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: const Text('Atenção!'),
            content: const Text('Etiqueta ja cadastrada anteriormente!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext),
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
      return;
    }
    if ((qrCode != null && qrCode != '') && (qrCode != '-1')) {
      finalizacaoDeVolume =
          await actions.buscaSeOVolumeEstaIniciadoEFinalizaEle(
        context,
        functions.buscaRegistro(
            fazId, oservId, FFAppState().trSincroniza.toList()),
        qrCode,
      );
      if (finalizacaoDeVolume == true) {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: const Text('Sucesso!'),
              content: const Text('Volume finalizado com sucesso!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext),
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
        context.safePop();
      } else {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: const Text('Ops!'),
              content: const Text('Um erro inesperado aconteceu!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext),
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
        return;
      }
    } else {
      return;
    }
  }

  /// Additional helper methods are added here.

  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
