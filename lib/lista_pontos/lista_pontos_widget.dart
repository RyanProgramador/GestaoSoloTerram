import '/backend/api_requests/api_calls.dart';
import '/components/foto_coleta_widget_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'lista_pontos_model.dart';
export 'lista_pontos_model.dart';

class ListaPontosWidget extends StatefulWidget {
  const ListaPontosWidget({
    super.key,
    required this.listaJsonPontos,
    required this.oservId,
    required this.fazId,
    required this.fazNome,
    required this.fazLatlng,
    required this.autoAuditoria,
    required this.quantidadeAutoAuditoria,
  });

  final List<dynamic>? listaJsonPontos;
  final int? oservId;
  final int? fazId;
  final String? fazNome;
  final LatLng? fazLatlng;
  final bool? autoAuditoria;
  final int? quantidadeAutoAuditoria;

  @override
  State<ListaPontosWidget> createState() => _ListaPontosWidgetState();
}

class _ListaPontosWidgetState extends State<ListaPontosWidget> {
  late ListaPontosModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListaPontosModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        FFAppState().trSincroniza =
            FFAppState().trSincroniza.toList().cast<dynamic>();
        FFAppState().listaColetasInciadas =
            FFAppState().listaColetasInciadas.toList().cast<dynamic>();
        FFAppState().PontosTotalmenteColetados =
            FFAppState().PontosTotalmenteColetados.toList().cast<dynamic>();
        FFAppState().PontosColetados =
            FFAppState().PontosColetados.toList().cast<dynamic>();
        FFAppState().PontosInacessiveis =
            FFAppState().PontosInacessiveis.toList().cast<dynamic>();
        FFAppState().trTalhoes =
            FFAppState().trTalhoes.toList().cast<dynamic>();
      });
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
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
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.safePop();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                size: 38.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Listas de pontos para coletar',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Outfit',
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      if (true)
                        Text(
                          'Realize a coleta dos pontos',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      var shouldSetState = false;
                                      _model.temNet =
                                          await actions.checkinternet();
                                      shouldSetState = true;
                                      if (!_model.temNet!) {
                                        context.pushNamed(
                                          'ColetaPontos',
                                          queryParameters: {
                                            'oservID': serializeParam(
                                              widget.oservId,
                                              ParamType.int,
                                            ),
                                            'fazid': serializeParam(
                                              widget.fazId,
                                              ParamType.int,
                                            ),
                                            'fazNome': serializeParam(
                                              widget.fazNome,
                                              ParamType.String,
                                            ),
                                            'fazLatlng': serializeParam(
                                              widget.fazLatlng,
                                              ParamType.LatLng,
                                            ),
                                            'autoAuditoria': serializeParam(
                                              widget.autoAuditoria,
                                              ParamType.bool,
                                            ),
                                            'quantidadeAutoAuditoria':
                                                serializeParam(
                                              widget.quantidadeAutoAuditoria,
                                              ParamType.int,
                                            ),
                                            'trPontos': serializeParam(
                                              widget.listaJsonPontos,
                                              ParamType.JSON,
                                              true,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: const TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 0),
                                            ),
                                          },
                                        );

                                        if (shouldSetState) setState(() {});
                                        return;
                                      }
                                      _model.trTalh = await TrOsServicosGroup
                                          .trTalhaoCall
                                          .call(
                                        urlApi: FFAppState().UrlApi,
                                        fazId: widget.fazId,
                                      );
                                      shouldSetState = true;
                                      setState(() {
                                        FFAppState().trTalhoes = getJsonField(
                                          (_model.trTalh?.jsonBody ?? ''),
                                          r'''$.dados''',
                                          true,
                                        )!
                                            .toList()
                                            .cast<dynamic>();
                                      });

                                      context.pushNamed(
                                        'ColetaPontos',
                                        queryParameters: {
                                          'oservID': serializeParam(
                                            widget.oservId,
                                            ParamType.int,
                                          ),
                                          'fazid': serializeParam(
                                            widget.fazId,
                                            ParamType.int,
                                          ),
                                          'fazNome': serializeParam(
                                            widget.fazNome,
                                            ParamType.String,
                                          ),
                                          'fazLatlng': serializeParam(
                                            widget.fazLatlng,
                                            ParamType.LatLng,
                                          ),
                                          'autoAuditoria': serializeParam(
                                            widget.autoAuditoria,
                                            ParamType.bool,
                                          ),
                                          'quantidadeAutoAuditoria':
                                              serializeParam(
                                            widget.quantidadeAutoAuditoria,
                                            ParamType.int,
                                          ),
                                          'trPontos': serializeParam(
                                            widget.listaJsonPontos,
                                            ParamType.JSON,
                                            true,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: const TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                            duration: Duration(milliseconds: 0),
                                          ),
                                        },
                                      );

                                      if (shouldSetState) setState(() {});
                                    },
                                    text: 'Realizar coletas',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.4,
                                      height: 50.0,
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                          ),
                                      elevation: 3.0,
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                  ),
                                  if (true == false)
                                    FFButtonWidget(
                                      onPressed: () async {
                                        context.pushNamed(
                                          'criacaoVolume',
                                          extra: <String, dynamic>{
                                            kTransitionInfoKey: const TransitionInfo(
                                              hasTransition: true,
                                              transitionType:
                                                  PageTransitionType.fade,
                                              duration:
                                                  Duration(milliseconds: 0),
                                            ),
                                          },
                                        );
                                      },
                                      text: 'Volume',
                                      options: FFButtonOptions(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.4,
                                        height: 50.0,
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.white,
                                            ),
                                        elevation: 3.0,
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total de pontos: ${widget.listaJsonPontos?.length.toString()}',
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                              Text(
                                'Pontos à coletar: ${valueOrDefault<String>(
                                  functions.quantosPontosFaltamParaColetar(
                                      widget.oservId?.toString(),
                                      widget.fazId?.toString(),
                                      widget.listaJsonPontos?.length
                                          .toString(),
                                      FFAppState()
                                          .PontosTotalmenteColetados
                                          .toList()),
                                  '0',
                                )}',
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 30.0),
                          child: Builder(
                            builder: (context) {
                              final pontosLista =
                                  widget.listaJsonPontos!.toList();
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: List.generate(pontosLista.length,
                                    (pontosListaIndex) {
                                  final pontosListaItem =
                                      pontosLista[pontosListaIndex];
                                  return Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      height: () {
                                        if (functions.contadorDeIntensNaLista(
                                                getJsonField(
                                              pontosListaItem,
                                              r'''$.profundidades''',
                                              true,
                                            )) ==
                                            4) {
                                          return 190.0;
                                        } else if (functions
                                                .contadorDeIntensNaLista(
                                                    getJsonField(
                                              pontosListaItem,
                                              r'''$.profundidades''',
                                              true,
                                            )) ==
                                            3) {
                                          return 170.0;
                                        } else if (functions
                                                .contadorDeIntensNaLista(
                                                    getJsonField(
                                              pontosListaItem,
                                              r'''$.profundidades''',
                                              true,
                                            )) ==
                                            2) {
                                          return 150.0;
                                        } else if (functions
                                                .contadorDeIntensNaLista(
                                                    getJsonField(
                                              pontosListaItem,
                                              r'''$.profundidades''',
                                              true,
                                            )) ==
                                            1) {
                                          return 125.0;
                                        } else {
                                          return 100.0;
                                        }
                                      }(),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE1E3E7),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: const Color(0xFF7BB3B6),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 8.0, 0.0, 8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 4.0),
                                                    child: Text(
                                                      'Ponto: ${getJsonField(
                                                        pontosListaItem,
                                                        r'''$.pont_numero''',
                                                      ).toString()}',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Outfit',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 24.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  6.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 100.0,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0x00FFFFFF),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Profundidade',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            16.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          4.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final profundidadesLista2 =
                                                                              getJsonField(
                                                                            pontosListaItem,
                                                                            r'''$.profundidades''',
                                                                          ).toList();
                                                                          return Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                List.generate(profundidadesLista2.length, (profundidadesLista2Index) {
                                                                              final profundidadesLista2Item = profundidadesLista2[profundidadesLista2Index];
                                                                              return Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Container(
                                                                                    height: 20.0,
                                                                                    decoration: const BoxDecoration(
                                                                                      color: Color(0x00FFFFFF),
                                                                                    ),
                                                                                    child: SizedBox(
                                                                                      width: 18.0,
                                                                                      height: 20.0,
                                                                                      child: custom_widgets.IconeComLegenda(
                                                                                        width: 18.0,
                                                                                        height: 20.0,
                                                                                        lista: FFAppState().trIcones,
                                                                                        termoDePesquisa: getJsonField(
                                                                                          profundidadesLista2Item,
                                                                                          r'''$.pprof_icone''',
                                                                                        ).toString(),
                                                                                        pathDePesquisa: 'ico_valor',
                                                                                        pathDeRetorno: 'ico_base64',
                                                                                        pathDeLegenda: 'ico_legenda',
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                                                                    child: Text(
                                                                                      valueOrDefault<String>(
                                                                                        functions.retornalegenda(
                                                                                            getJsonField(
                                                                                              profundidadesLista2Item,
                                                                                              r'''$.pprof_icone''',
                                                                                            ).toString(),
                                                                                            FFAppState().trIcones.toList()),
                                                                                        'Erro',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Readex Pro',
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                            fontWeight: FontWeight.w200,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            }).divide(const SizedBox(height: 4.0)),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Text(
                                                                  'Situação',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            16.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          4.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final profundidadesLista2 =
                                                                              getJsonField(
                                                                            pontosListaItem,
                                                                            r'''$.profundidades''',
                                                                          ).toList();
                                                                          return Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                List.generate(profundidadesLista2.length, (profundidadesLista2Index) {
                                                                              final profundidadesLista2Item = profundidadesLista2[profundidadesLista2Index];
                                                                              return Text(
                                                                                valueOrDefault<String>(
                                                                                  functions.pesquisaParaVerSeOPontoFoiColetado(
                                                                                      getJsonField(
                                                                                        profundidadesLista2Item,
                                                                                        r'''$.pprof_id''',
                                                                                      ),
                                                                                      FFAppState().PontosColetados.toList(),
                                                                                      FFAppState().PontosInacessiveis.toList(),
                                                                                      functions.buscaRegistro(widget.fazId!, widget.oservId!, FFAppState().trSincroniza.toList())),
                                                                                  'Ops!',
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Readex Pro',
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                      fontWeight: FontWeight.w200,
                                                                                    ),
                                                                              );
                                                                            }).divide(const SizedBox(height: 4.0)),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                  'Foto',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            16.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          4.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final listaFotos =
                                                                              getJsonField(
                                                                            pontosListaItem,
                                                                            r'''$.profundidades''',
                                                                          ).toList();
                                                                          return Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.end,
                                                                            children:
                                                                                List.generate(listaFotos.length, (listaFotosIndex) {
                                                                              final listaFotosItem = listaFotos[listaFotosIndex];
                                                                              return InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  if (getJsonField(
                                                                                        listaFotosItem,
                                                                                        r'''$.pprof_id''',
                                                                                      ) !=
                                                                                      null) {
                                                                                    if (functions.pesquisaFotoBas64(
                                                                                            getJsonField(
                                                                                              listaFotosItem,
                                                                                              r'''$.pprof_id''',
                                                                                            ).toString(),
                                                                                            FFAppState().PontosColetados.toList(),
                                                                                            FFAppState().PontosInacessiveis.toList()) !=
                                                                                        'Pending or Error') {
                                                                                      if (!(functions.pesquisaFotoBas64(
                                                                                                  getJsonField(
                                                                                                    listaFotosItem,
                                                                                                    r'''$.pprof_id''',
                                                                                                  ).toString(),
                                                                                                  FFAppState().PontosColetados.toList(),
                                                                                                  FFAppState().PontosInacessiveis.toList()) !=
                                                                                              null &&
                                                                                          functions.pesquisaFotoBas64(
                                                                                                  getJsonField(
                                                                                                    listaFotosItem,
                                                                                                    r'''$.pprof_id''',
                                                                                                  ).toString(),
                                                                                                  FFAppState().PontosColetados.toList(),
                                                                                                  FFAppState().PontosInacessiveis.toList()) !=
                                                                                              '')) {
                                                                                        await showDialog(
                                                                                          context: context,
                                                                                          builder: (alertDialogContext) {
                                                                                            return AlertDialog(
                                                                                              title: Text(functions.pesquisaFotoBas64HTML(
                                                                                                  getJsonField(
                                                                                                    listaFotosItem,
                                                                                                    r'''$.pprof_id''',
                                                                                                  ).toString(),
                                                                                                  FFAppState().PontosColetados.toList(),
                                                                                                  FFAppState().PontosInacessiveis.toList(),
                                                                                                  functions.buscaRegistro(widget.fazId!, widget.oservId!, FFAppState().trSincroniza.toList()))!),
                                                                                              content: const Text('teste'),
                                                                                              actions: [
                                                                                                TextButton(
                                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                  child: const Text('Ok'),
                                                                                                ),
                                                                                              ],
                                                                                            );
                                                                                          },
                                                                                        );
                                                                                        await showDialog(
                                                                                          context: context,
                                                                                          builder: (alertDialogContext) {
                                                                                            return AlertDialog(
                                                                                              title: const Text('Ops!'),
                                                                                              content: const Text('Não foi capturada foto para essa coleta!'),
                                                                                              actions: [
                                                                                                TextButton(
                                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                  child: const Text('Entendi'),
                                                                                                ),
                                                                                              ],
                                                                                            );
                                                                                          },
                                                                                        );
                                                                                        return;
                                                                                      }
                                                                                    } else {
                                                                                      if (functions.pesquisaFotoBas64HTML(
                                                                                                  getJsonField(
                                                                                                    listaFotosItem,
                                                                                                    r'''$.pprof_id''',
                                                                                                  ).toString(),
                                                                                                  FFAppState().PontosColetados.toList(),
                                                                                                  FFAppState().PontosInacessiveis.toList(),
                                                                                                  functions.buscaRegistro(widget.fazId!, widget.oservId!, FFAppState().trSincroniza.toList())) !=
                                                                                              null &&
                                                                                          functions.pesquisaFotoBas64HTML(
                                                                                                  getJsonField(
                                                                                                    listaFotosItem,
                                                                                                    r'''$.pprof_id''',
                                                                                                  ).toString(),
                                                                                                  FFAppState().PontosColetados.toList(),
                                                                                                  FFAppState().PontosInacessiveis.toList(),
                                                                                                  functions.buscaRegistro(widget.fazId!, widget.oservId!, FFAppState().trSincroniza.toList())) !=
                                                                                              '') {
                                                                                        await showDialog(
                                                                                          context: context,
                                                                                          builder: (alertDialogContext) {
                                                                                            return AlertDialog(
                                                                                              title: Text(functions.pesquisaFotoBas64HTML(
                                                                                                  getJsonField(
                                                                                                    listaFotosItem,
                                                                                                    r'''$.pprof_id''',
                                                                                                  ).toString(),
                                                                                                  FFAppState().PontosColetados.toList(),
                                                                                                  FFAppState().PontosInacessiveis.toList(),
                                                                                                  functions.buscaRegistro(widget.fazId!, widget.oservId!, FFAppState().trSincroniza.toList()))!),
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
                                                                                      await showDialog(
                                                                                        context: context,
                                                                                        builder: (alertDialogContext) {
                                                                                          return AlertDialog(
                                                                                            title: const Text('Ops!'),
                                                                                            content: const Text('Não existe imagem capturada para essa coleta.'),
                                                                                            actions: [
                                                                                              TextButton(
                                                                                                onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                child: const Text('Fechar'),
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                      return;
                                                                                    }

                                                                                    await showModalBottomSheet(
                                                                                      isScrollControlled: true,
                                                                                      backgroundColor: Colors.transparent,
                                                                                      enableDrag: false,
                                                                                      context: context,
                                                                                      builder: (context) {
                                                                                        return GestureDetector(
                                                                                          onTap: () => _model.unfocusNode.canRequestFocus ? FocusScope.of(context).requestFocus(_model.unfocusNode) : FocusScope.of(context).unfocus(),
                                                                                          child: Padding(
                                                                                            padding: MediaQuery.viewInsetsOf(context),
                                                                                            child: FotoColetaWidgetWidget(
                                                                                              base64: functions.pesquisaFotoBas64(
                                                                                                  getJsonField(
                                                                                                    listaFotosItem,
                                                                                                    r'''$.pprof_id''',
                                                                                                  ).toString(),
                                                                                                  FFAppState().PontosColetados.toList(),
                                                                                                  FFAppState().PontosInacessiveis.toList())!,
                                                                                              marcadorNomeIdPontoNumero: getJsonField(
                                                                                                pontosListaItem,
                                                                                                r'''$.pont_numero''',
                                                                                              ).toString(),
                                                                                              profundidade: functions.retornalegenda(
                                                                                                  getJsonField(
                                                                                                    listaFotosItem,
                                                                                                    r'''$.pprof_icone''',
                                                                                                  ).toString(),
                                                                                                  FFAppState().trIcones.toList())!,
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                    ).then((value) => safeSetState(() {}));

                                                                                    return;
                                                                                  } else {
                                                                                    await showDialog(
                                                                                      context: context,
                                                                                      builder: (alertDialogContext) {
                                                                                        return AlertDialog(
                                                                                          title: const Text('Ops!'),
                                                                                          content: const Text('Erro na variavel.'),
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
                                                                                },
                                                                                child: FaIcon(
                                                                                  FontAwesomeIcons.images,
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  size: 21.0,
                                                                                ),
                                                                              );
                                                                            }).divide(const SizedBox(height: 2.0)),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
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
                                    ),
                                  );
                                }).divide(const SizedBox(height: 10.0)),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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
