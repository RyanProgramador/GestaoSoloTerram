import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'coleta_pontos_model.dart';
export 'coleta_pontos_model.dart';

class ColetaPontosWidget extends StatefulWidget {
  const ColetaPontosWidget({
    super.key,
    required this.oservID,
    required this.fazid,
    required this.fazNome,
    required this.fazLatlng,
    required this.autoAuditoria,
    required this.quantidadeAutoAuditoria,
    required this.trPontos,
  });

  final int? oservID;
  final int? fazid;
  final String? fazNome;
  final LatLng? fazLatlng;
  final bool? autoAuditoria;
  final int? quantidadeAutoAuditoria;
  final List<dynamic>? trPontos;

  @override
  State<ColetaPontosWidget> createState() => _ColetaPontosWidgetState();
}

class _ColetaPontosWidgetState extends State<ColetaPontosWidget> {
  late ColetaPontosModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ColetaPontosModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.timerController.onStartTimer();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryText,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(0.0),
                          topRight: Radius.circular(0.0),
                        ),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: custom_widgets.ColetaPontos(
                          width: double.infinity,
                          height: double.infinity,
                          oservid: widget.oservID?.toString(),
                          fazId: widget.fazid?.toString(),
                          fazNome: widget.fazNome,
                          fazLatlng: widget.fazLatlng,
                          autoAuditoria: widget.autoAuditoria,
                          quantidadeAutoAuditoria:
                              widget.quantidadeAutoAuditoria?.toString(),
                          pontos: widget.trPontos,
                          podeColetarOuNaoPodeColetar2:
                              functions.buscaSeAEtapaEstaIniciada(
                                  functions.buscaRegistro(
                                      widget.fazid!,
                                      widget.oservID!,
                                      FFAppState().trSincroniza.toList())),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 150.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(22.0),
                          bottomRight: Radius.circular(22.0),
                          topLeft: Radius.circular(0.0),
                          topRight: Radius.circular(0.0),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-0.88, -0.45),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                var confirmDialogResponse =
                                    await showDialog<bool>(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: const Text('Alerta!'),
                                              content: const Text(
                                                  'Você tem certeza que quer sair da coleta?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext,
                                                          false),
                                                  child: const Text('Não'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext,
                                                          true),
                                                  child: const Text('Sim'),
                                                ),
                                              ],
                                            );
                                          },
                                        ) ??
                                        false;
                                if (confirmDialogResponse) {
                                  await actions.atualizaTrSinc(
                                    widget.fazid,
                                    widget.oservID,
                                  );
                                  await Future.delayed(
                                      const Duration(milliseconds: 1000));
                                } else {
                                  return;
                                }

                                context.safePop();
                                setState(() {
                                  FFAppState().trSincroniza = FFAppState()
                                      .trSincroniza
                                      .toList()
                                      .cast<dynamic>();
                                });
                              },
                              child: Icon(
                                Icons.arrow_back_sharp,
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                size: 38.0,
                              ),
                            ),
                          ),
                          const Align(
                            alignment: AlignmentDirectional(0.0, 0.51),
                            child: SizedBox(
                              width: double.infinity,
                              height: 30.0,
                              child: custom_widgets.LocationAccuracyCheck(
                                width: double.infinity,
                                height: 30.0,
                              ),
                            ),
                          ),
                          if (true == true)
                            Opacity(
                              opacity: 0.001,
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, -1.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 34.0, 0.0, 0.0),
                                  child: FlutterFlowTimer(
                                    initialTime: _model.timerMilliseconds,
                                    getDisplayTime: (value) =>
                                        StopWatchTimer.getDisplayTime(
                                      value,
                                      hours: false,
                                      milliSecond: false,
                                    ),
                                    controller: _model.timerController,
                                    updateStateInterval:
                                        const Duration(milliseconds: 500),
                                    onChanged:
                                        (value, displayTime, shouldUpdate) {
                                      _model.timerMilliseconds = value;
                                      _model.timerValue = displayTime;
                                      if (shouldUpdate) setState(() {});
                                    },
                                    onEnded: () async {
                                      setState(() {
                                        FFAppState().listaColetasInciadas =
                                            FFAppState()
                                                .listaColetasInciadas
                                                .toList()
                                                .cast<dynamic>();
                                        FFAppState().PontosTotalmenteColetados =
                                            FFAppState()
                                                .PontosTotalmenteColetados
                                                .toList()
                                                .cast<dynamic>();
                                        FFAppState().PontosColetados =
                                            FFAppState()
                                                .PontosColetados
                                                .toList()
                                                .cast<dynamic>();
                                        FFAppState().PontosInacessiveis =
                                            FFAppState()
                                                .PontosInacessiveis
                                                .toList()
                                                .cast<dynamic>();
                                        FFAppState().trTalhoes = FFAppState()
                                            .trTalhoes
                                            .toList()
                                            .cast<dynamic>();
                                        FFAppState().trTalhoesEmCadaServico =
                                            FFAppState()
                                                .trTalhoesEmCadaServico
                                                .toList()
                                                .cast<dynamic>();
                                        FFAppState().dadosTrBuscaPontosLista =
                                            FFAppState()
                                                .dadosTrBuscaPontosLista
                                                .toList()
                                                .cast<dynamic>();
                                      });
                                      _model.timerController.onResetTimer();

                                      _model.timerController.onStartTimer();
                                    },
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
