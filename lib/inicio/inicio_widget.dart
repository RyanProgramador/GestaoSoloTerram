import '/backend/api_requests/api_calls.dart';
import '/components/loading_sinc_widget.dart';
import '/components/loading_widget.dart';
import '/components/sem_servicos_no_momento_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'inicio_model.dart';
export 'inicio_model.dart';

class InicioWidget extends StatefulWidget {
  const InicioWidget({super.key});

  @override
  State<InicioWidget> createState() => _InicioWidgetState();
}

class _InicioWidgetState extends State<InicioWidget> {
  late InicioModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InicioModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        FFAppState().login = FFAppState().login;
        FFAppState().senha = FFAppState().senha;
        FFAppState().diadoUltimoAcesso = FFAppState().diadoUltimoAcesso;
      });
      _model.temInternet = await actions.checkinternet();
      setState(() {
        _model.net = _model.temInternet!;
      });
      await requestPermission(locationPermission);
      if (_model.temInternet!) {
        _model.apiTrOsServicos = await TrOsServicosGroup.trOsServicosCall.call(
          urlApi: FFAppState().UrlApi,
          tecnicoId: '1',
        );
        if (TrOsServicosGroup.trOsServicosCall.statusTrBuscaOsServicos(
          (_model.apiTrOsServicos?.jsonBody ?? ''),
        )!) {
          setState(() {
            FFAppState().trOsServicos = TrOsServicosGroup.trOsServicosCall
                .dadosTrBuscaOsServicos(
                  (_model.apiTrOsServicos?.jsonBody ?? ''),
                )!
                .toList()
                .cast<dynamic>();
          });
        } else {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: const Text('Ops!'),
                content: Text(getJsonField(
                  (_model.apiTrOsServicos?.jsonBody ?? ''),
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
        }

        return;
      }
    });
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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  height: 100.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00736D),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Captura_de_tela_2024-02-14_173810.png',
                          width: double.infinity,
                          height: 90.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  width: double.infinity,
                  height: 100.0,
                  decoration: const BoxDecoration(
                    color: Color(0x00FFFFFF),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (_model.net == true)
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: FutureBuilder<ApiCallResponse>(
                            future: (_model.apiRequestCompleter ??= Completer<
                                    ApiCallResponse>()
                                  ..complete(
                                      TrOsServicosGroup.trOsServicosCall.call(
                                    urlApi: FFAppState().UrlApi,
                                    tecnicoId:
                                        FFAppState().tecnicoid.toString(),
                                  )))
                                .future,
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 40.0,
                                    height: 40.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final columnTrOsServicosResponse = snapshot.data!;
                              return Builder(
                                builder: (context) {
                                  final trOsServicos =
                                      TrOsServicosGroup.trOsServicosCall
                                              .dadosTrBuscaOsServicos(
                                                columnTrOsServicosResponse
                                                    .jsonBody,
                                              )
                                              ?.toList() ??
                                          [];
                                  if (trOsServicos.isEmpty) {
                                    return const SemServicosNoMomentoWidget();
                                  }
                                  return RefreshIndicator(
                                    onRefresh: () async {
                                      setState(() =>
                                          _model.apiRequestCompleter = null);
                                      await _model.waitForApiRequestCompleted();
                                    },
                                    child: SingleChildScrollView(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children:
                                            List.generate(trOsServicos.length,
                                                (trOsServicosIndex) {
                                          final trOsServicosItem =
                                              trOsServicos[trOsServicosIndex];
                                          return Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 78.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                border: Border.all(
                                                  color: const Color(0xFF00736D),
                                                ),
                                              ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    enableDrag: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return GestureDetector(
                                                        onTap: () => _model
                                                                .unfocusNode
                                                                .canRequestFocus
                                                            ? FocusScope.of(
                                                                    context)
                                                                .requestFocus(_model
                                                                    .unfocusNode)
                                                            : FocusScope.of(
                                                                    context)
                                                                .unfocus(),
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child: LoadingWidget(
                                                            tipo: 'Coleta',
                                                            fazNome:
                                                                getJsonField(
                                                              trOsServicosItem,
                                                              r'''$.faz_nome''',
                                                            ).toString(),
                                                            data: getJsonField(
                                                              trOsServicosItem,
                                                              r'''$.oserv_dthr_agendamento''',
                                                            ).toString(),
                                                            observacao:
                                                                getJsonField(
                                                              trOsServicosItem,
                                                              r'''$.oserv_observacao''',
                                                            ).toString(),
                                                            fazlatlng: functions
                                                                .listaStrToListaLatLng(
                                                                    getJsonField(
                                                                      trOsServicosItem,
                                                                      r'''$.faz_latitude''',
                                                                    ).toString(),
                                                                    getJsonField(
                                                                      trOsServicosItem,
                                                                      r'''$.faz_longitude''',
                                                                    ).toString())!,
                                                            fazCidade:
                                                                getJsonField(
                                                              trOsServicosItem,
                                                              r'''$.faz_cidade''',
                                                            ).toString(),
                                                            fazEstado:
                                                                getJsonField(
                                                              trOsServicosItem,
                                                              r'''$.faz_estado''',
                                                            ).toString(),
                                                            servico:
                                                                getJsonField(
                                                              trOsServicosItem,
                                                              r'''$.oserv_id''',
                                                            ),
                                                            fazID: getJsonField(
                                                              trOsServicosItem,
                                                              r'''$.os_id_faz''',
                                                            ),
                                                            fazlocalizacao:
                                                                getJsonField(
                                                              trOsServicosItem,
                                                              r'''$.faz_localizacao''',
                                                            ).toString(),
                                                            autoAuditoria:
                                                                getJsonField(
                                                              trOsServicosItem,
                                                              r'''$.oserv_auto_auditoria''',
                                                            ),
                                                            quantidadeDeIntervaloDeFotosAutoAuditoria:
                                                                getJsonField(
                                                              trOsServicosItem,
                                                              r'''$.oserv_quantos_pontos''',
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      safeSetState(() {}));
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                FaIcon(
                                                                  FontAwesomeIcons
                                                                      .vials,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  size: 30.0,
                                                                ),
                                                                Text(
                                                                  'Coleta',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '#${getJsonField(
                                                                  trOsServicosItem,
                                                                  r'''$.oserv_id''',
                                                                ).toString()}',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Outfit',
                                                                      fontSize:
                                                                          16.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w200,
                                                                    ),
                                                              ),
                                                              Text(
                                                                'Fazenda: ${getJsonField(
                                                                  trOsServicosItem,
                                                                  r'''$.faz_nome''',
                                                                ).toString()}'
                                                                    .maybeHandleOverflow(
                                                                  maxChars: 16,
                                                                  replacement:
                                                                      '…',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Outfit',
                                                                      fontSize:
                                                                          16.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                              ),
                                                              Text(
                                                                getJsonField(
                                                                  trOsServicosItem,
                                                                  r'''$.oserv_dthr_agendamento''',
                                                                ).toString(),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Outfit',
                                                                      fontSize:
                                                                          12.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w200,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                1.0, 0.0),
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    var shouldSetState =
                                                                        false;
                                                                    if (functions.pesquisaOservEFazIdNoTrSinc(
                                                                        getJsonField(
                                                                          trOsServicosItem,
                                                                          r'''$.oserv_id''',
                                                                        ).toString(),
                                                                        getJsonField(
                                                                          trOsServicosItem,
                                                                          r'''$.os_id_faz''',
                                                                        ).toString(),
                                                                        FFAppState().trSincroniza.toList())!) {
                                                                      _model.netcheck =
                                                                          await actions
                                                                              .checkinternet();
                                                                      shouldSetState =
                                                                          true;
                                                                      if (_model
                                                                              .netcheck !=
                                                                          true) {
                                                                        await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (alertDialogContext) {
                                                                            return AlertDialog(
                                                                              title: const Text('Ops!'),
                                                                              content: const Text('Ative a internet para sincronizar.'),
                                                                              actions: [
                                                                                TextButton(
                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                  child: const Text('Entendi'),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                        if (shouldSetState) {
                                                                          setState(
                                                                              () {});
                                                                        }
                                                                        return;
                                                                      }
                                                                      await showModalBottomSheet(
                                                                        isScrollControlled:
                                                                            true,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        enableDrag:
                                                                            false,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return GestureDetector(
                                                                            onTap: () => _model.unfocusNode.canRequestFocus
                                                                                ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                                : FocusScope.of(context).unfocus(),
                                                                            child:
                                                                                Padding(
                                                                              padding: MediaQuery.viewInsetsOf(context),
                                                                              child: LoadingSincWidget(
                                                                                servico: getJsonField(
                                                                                  trOsServicosItem,
                                                                                  r'''$.oserv_id''',
                                                                                ),
                                                                                fazID: getJsonField(
                                                                                  trOsServicosItem,
                                                                                  r'''$.os_id_faz''',
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ).then((value) =>
                                                                          safeSetState(
                                                                              () {}));
                                                                    } else {
                                                                      await showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (alertDialogContext) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                const Text('Ops!'),
                                                                            content:
                                                                                const Text('Você precisa ter no mínimo um ponto coletado para poder sincronizar.'),
                                                                            actions: [
                                                                              TextButton(
                                                                                onPressed: () => Navigator.pop(alertDialogContext),
                                                                                child: const Text('Fechar'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    }

                                                                    if (shouldSetState) {
                                                                      setState(
                                                                          () {});
                                                                    }
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .cloud_sync_outlined,
                                                                    color: functions.pesquisaOservEFazIdNoTrSinc(
                                                                            getJsonField(
                                                                              trOsServicosItem,
                                                                              r'''$.oserv_id''',
                                                                            ).toString(),
                                                                            getJsonField(
                                                                              trOsServicosItem,
                                                                              r'''$.os_id_faz''',
                                                                            ).toString(),
                                                                            FFAppState().trSincroniza.toList())!
                                                                        ? FlutterFlowTheme.of(context).primary
                                                                        : const Color(0x3100736D),
                                                                    size: 55.0,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }).divide(const SizedBox(height: 10.0)),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      if (_model.net == false)
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Builder(
                            builder: (context) {
                              final trOsServicos =
                                  FFAppState().trOsServicos.toList();
                              if (trOsServicos.isEmpty) {
                                return const SemServicosNoMomentoWidget();
                              }
                              return SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(trOsServicos.length,
                                      (trOsServicosIndex) {
                                    final trOsServicosItem =
                                        trOsServicos[trOsServicosIndex];
                                    return Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 78.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: const Color(0xFF00736D),
                                          ),
                                        ),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              enableDrag: false,
                                              context: context,
                                              builder: (context) {
                                                return GestureDetector(
                                                  onTap: () => _model
                                                          .unfocusNode
                                                          .canRequestFocus
                                                      ? FocusScope.of(context)
                                                          .requestFocus(_model
                                                              .unfocusNode)
                                                      : FocusScope.of(context)
                                                          .unfocus(),
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child: LoadingWidget(
                                                      tipo: 'Coleta',
                                                      fazNome: getJsonField(
                                                        trOsServicosItem,
                                                        r'''$.faz_nome''',
                                                      ).toString(),
                                                      data: getJsonField(
                                                        trOsServicosItem,
                                                        r'''$.oserv_dthr_agendamento''',
                                                      ).toString(),
                                                      observacao: getJsonField(
                                                        trOsServicosItem,
                                                        r'''$.oserv_observacao''',
                                                      ).toString(),
                                                      fazlatlng: functions
                                                          .listaStrToListaLatLng(
                                                              getJsonField(
                                                                trOsServicosItem,
                                                                r'''$.faz_latitude''',
                                                              ).toString(),
                                                              getJsonField(
                                                                trOsServicosItem,
                                                                r'''$.faz_longitude''',
                                                              ).toString())!,
                                                      fazCidade: getJsonField(
                                                        trOsServicosItem,
                                                        r'''$.faz_cidade''',
                                                      ).toString(),
                                                      fazEstado: getJsonField(
                                                        trOsServicosItem,
                                                        r'''$.faz_estado''',
                                                      ).toString(),
                                                      servico: getJsonField(
                                                        trOsServicosItem,
                                                        r'''$.oserv_id''',
                                                      ),
                                                      fazID: getJsonField(
                                                        trOsServicosItem,
                                                        r'''$.os_id_faz''',
                                                      ),
                                                      fazlocalizacao:
                                                          getJsonField(
                                                        trOsServicosItem,
                                                        r'''$.faz_localizacao''',
                                                      ).toString(),
                                                      autoAuditoria:
                                                          getJsonField(
                                                        trOsServicosItem,
                                                        r'''$.oserv_auto_auditoria''',
                                                      ),
                                                      quantidadeDeIntervaloDeFotosAutoAuditoria:
                                                          getJsonField(
                                                        trOsServicosItem,
                                                        r'''$.oserv_quantos_pontos''',
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Container(
                                                    decoration: const BoxDecoration(),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          FaIcon(
                                                            FontAwesomeIcons
                                                                .vials,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            size: 30.0,
                                                          ),
                                                          Text(
                                                            'Coleta',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  decoration: const BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '#${getJsonField(
                                                            trOsServicosItem,
                                                            r'''$.oserv_id''',
                                                          ).toString()}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Outfit',
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                              ),
                                                        ),
                                                        Text(
                                                          'Fazenda: ${getJsonField(
                                                            trOsServicosItem,
                                                            r'''$.faz_nome''',
                                                          ).toString()}'
                                                              .maybeHandleOverflow(
                                                            maxChars: 16,
                                                            replacement: '…',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Outfit',
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                        Text(
                                                          getJsonField(
                                                            trOsServicosItem,
                                                            r'''$.oserv_dthr_agendamento''',
                                                          ).toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Outfit',
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          1.0, 0.0),
                                                  child: Container(
                                                    decoration: const BoxDecoration(),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  16.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              var shouldSetState =
                                                                  false;
                                                              if (functions.pesquisaOservEFazIdNoTrSinc(
                                                                  getJsonField(
                                                                    trOsServicosItem,
                                                                    r'''$.oserv_id''',
                                                                  ).toString(),
                                                                  getJsonField(
                                                                    trOsServicosItem,
                                                                    r'''$.os_id_faz''',
                                                                  ).toString(),
                                                                  FFAppState().trSincroniza.toList())!) {
                                                                _model.netcheck2 =
                                                                    await actions
                                                                        .checkinternet();
                                                                shouldSetState =
                                                                    true;
                                                                if (_model
                                                                        .netcheck2 !=
                                                                    true) {
                                                                  await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (alertDialogContext) {
                                                                      return AlertDialog(
                                                                        title: const Text(
                                                                            'Ops!'),
                                                                        content:
                                                                            const Text('Ative a internet para sincronizar.'),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext),
                                                                            child:
                                                                                const Text('Entendi'),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  );
                                                                  if (shouldSetState) {
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                  return;
                                                                }
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  enableDrag:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return GestureDetector(
                                                                      onTap: () => _model
                                                                              .unfocusNode
                                                                              .canRequestFocus
                                                                          ? FocusScope.of(context).requestFocus(_model
                                                                              .unfocusNode)
                                                                          : FocusScope.of(context)
                                                                              .unfocus(),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            LoadingSincWidget(
                                                                          servico:
                                                                              getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$.oserv_id''',
                                                                          ),
                                                                          fazID:
                                                                              getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$.os_id_faz''',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(
                                                                        () {}));
                                                              } else {
                                                                await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (alertDialogContext) {
                                                                    return AlertDialog(
                                                                      title: const Text(
                                                                          'Ops!'),
                                                                      content: const Text(
                                                                          'Você precisa ter no mínimo um ponto coletado para poder sincronizar.'),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed: () =>
                                                                              Navigator.pop(alertDialogContext),
                                                                          child:
                                                                              const Text('Fechar'),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              }

                                                              if (shouldSetState) {
                                                                setState(() {});
                                                              }
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .cloud_sync_outlined,
                                                              color: functions
                                                                      .pesquisaOservEFazIdNoTrSinc(
                                                                          getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$.oserv_id''',
                                                                          )
                                                                              .toString(),
                                                                          getJsonField(
                                                                            trOsServicosItem,
                                                                            r'''$.os_id_faz''',
                                                                          )
                                                                              .toString(),
                                                                          FFAppState()
                                                                              .trSincroniza
                                                                              .toList())!
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary
                                                                  : const Color(
                                                                      0x3100736D),
                                                              size: 55.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).divide(const SizedBox(height: 10.0)),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
