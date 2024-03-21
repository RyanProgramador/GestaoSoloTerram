import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'criacao_volume_widget.dart' show CriacaoVolumeWidget;
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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

  Future finalizaOVolume(
    BuildContext context, {
    required int? fazId,
    required int? oservId,
  }) async {
    var qrCode = '';
    bool? finalizacaoDeVolume;

    qrCode = await FlutterBarcodeScanner.scanBarcode(
      '#C62828', // scanning line color
      'Cancel', // cancel button text
      true, // whether to show the flash icon
      ScanMode.QR,
    );

    if (functions.verificaSeQrCodeJaFoiLidoOuNao(
        functions.buscaRegistro(
            fazId!, oservId!, FFAppState().trSincroniza.toList()),
        qrCode)!) {
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
    if ((qrCode != '') && (qrCode != '-1')) {
      finalizacaoDeVolume =
          await actions.buscaSeOVolumeEstaIniciadoEFinalizaEle(
        context,
        functions.buscaRegistro(
            fazId, oservId, FFAppState().trSincroniza.toList()),
        qrCode,
      );
      if (finalizacaoDeVolume) {
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

        context.goNamed(
          'Inicio',
          extra: <String, dynamic>{
            kTransitionInfoKey: const TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
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
}
