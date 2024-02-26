import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'loading_sinc_model.dart';
export 'loading_sinc_model.dart';

class LoadingSincWidget extends StatefulWidget {
  const LoadingSincWidget({
    super.key,
    required this.servico,
    required this.fazID,
  });

  final int? servico;
  final int? fazID;

  @override
  State<LoadingSincWidget> createState() => _LoadingSincWidgetState();
}

class _LoadingSincWidgetState extends State<LoadingSincWidget> {
  late LoadingSincModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingSincModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.trSinc =
          await TrOsServicosGroup.trSincronizaPontosColetadosCall.call(
        urlApi: FFAppState().UrlApi,
        pontosJson: functions.buscaRegistro(widget.fazID!.toString(),
            widget.servico!.toString(), FFAppState().trSincroniza.toList()),
      );
      if (getJsonField(
        (_model.trSinc?.jsonBody ?? ''),
        r'''$.status''',
      )) {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: const Text('Sucesso!'),
              content: Text(getJsonField(
                (_model.trSinc?.jsonBody ?? ''),
                r'''$.message''',
              ).toString().toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext),
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
        Navigator.pop(context);
      } else {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: const Text('Ops!'),
              content: Text(getJsonField(
                (_model.trSinc?.jsonBody ?? ''),
                r'''$.message''',
              ).toString().toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext),
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
        Navigator.pop(context);
        return;
      }
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0x23000000),
      ),
      child: SizedBox(
        width: 100.0,
        height: 100.0,
        child: custom_widgets.LoadingCircle(
          width: 100.0,
          height: 100.0,
          color: FlutterFlowTheme.of(context).primary,
          circleRadius: 2.0,
        ),
      ),
    );
  }
}