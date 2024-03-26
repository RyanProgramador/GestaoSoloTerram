import '/backend/api_requests/api_calls.dart';
import '/components/foto_coleta_widget_widget.dart';
import '/components/foto_coleta_widgethtml_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
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
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SingleChildScrollView(
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
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (true == false)
                                          FFButtonWidget(
                                            onPressed: () {
                                              print('Button pressed ...');
                                            },
                                            text: '',
                                            icon: const Icon(
                                              Icons.search_sharp,
                                              color: Colors.white,
                                              size: 32.0,
                                            ),
                                            options: FFButtonOptions(
                                              width: 60.0,
                                              height: 60.0,
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 0.0, 0.0, 0.0),
                                              iconPadding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: Colors.white,
                                                      ),
                                              elevation: 3.0,
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                            ),
                                          ),
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
                                                  'autoAuditoria':
                                                      serializeParam(
                                                    widget.autoAuditoria,
                                                    ParamType.bool,
                                                  ),
                                                  'quantidadeAutoAuditoria':
                                                      serializeParam(
                                                    widget
                                                        .quantidadeAutoAuditoria,
                                                    ParamType.int,
                                                  ),
                                                  'trPontos': serializeParam(
                                                    widget.listaJsonPontos,
                                                    ParamType.JSON,
                                                    true,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                      const TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                        PageTransitionType.fade,
                                                    duration: Duration(
                                                        milliseconds: 0),
                                                  ),
                                                },
                                              );

                                              if (shouldSetState) {
                                                setState(() {});
                                              }
                                              return;
                                            }
                                            _model.trTalh =
                                                await TrOsServicosGroup
                                                    .trTalhaoCall
                                                    .call(
                                              urlApi: FFAppState().UrlApi,
                                              fazId: widget.fazId,
                                            );
                                            shouldSetState = true;
                                            setState(() {
                                              FFAppState().trTalhoes =
                                                  getJsonField(
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
                                                  widget
                                                      .quantidadeAutoAuditoria,
                                                  ParamType.int,
                                                ),
                                                'trPontos': serializeParam(
                                                  widget.listaJsonPontos,
                                                  ParamType.JSON,
                                                  true,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey:
                                                    const TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                      PageTransitionType.fade,
                                                  duration:
                                                      Duration(milliseconds: 0),
                                                ),
                                              },
                                            );

                                            if (shouldSetState) {
                                              setState(() {});
                                            }
                                          },
                                          text: '',
                                          icon: const FaIcon(
                                            FontAwesomeIcons.braille,
                                            color: Colors.white,
                                            size: 24.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: 60.0,
                                            height: 60.0,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
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
                                                BorderRadius.circular(100.0),
                                          ),
                                        ),
                                        if (true == false)
                                          FFButtonWidget(
                                            onPressed: () async {
                                              var shouldSetState = false;
                                              var confirmDialogResponse =
                                                  await showDialog<bool>(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Atenção!'),
                                                            content: const Text(
                                                                'Deseja iniciar um volume?'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext,
                                                                        false),
                                                                child:
                                                                    const Text('Não'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext,
                                                                        true),
                                                                child:
                                                                    const Text('Sim'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ) ??
                                                      false;
                                              if (!confirmDialogResponse) {
                                                if (shouldSetState) {
                                                  setState(() {});
                                                }
                                                return;
                                              }
                                              if (functions
                                                  .buscaSeAEtapaEstaIniciada(
                                                      functions.buscaRegistro(
                                                          widget.fazId!,
                                                          widget.oservId!,
                                                          FFAppState()
                                                              .trSincroniza
                                                              .toList()))!) {
                                                _model.buscaOVolumeIniciado =
                                                    await actions
                                                        .buscaSeOVolumeEstaIniciadoENaoFinalizado(
                                                  context,
                                                  functions.buscaRegistro(
                                                      widget.fazId!,
                                                      widget.oservId!,
                                                      FFAppState()
                                                          .trSincroniza
                                                          .toList()),
                                                );
                                                shouldSetState = true;
                                                if (!_model
                                                    .buscaOVolumeIniciado!) {
                                                  if (shouldSetState) {
                                                    setState(() {});
                                                  }
                                                  return;
                                                }
                                              } else {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return AlertDialog(
                                                      title: const Text('Ops!'),
                                                      content: const Text(
                                                          'Voçê precisa iniciar uma etapa para criar um volume!'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child:
                                                              const Text('Entendi'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                if (shouldSetState) {
                                                  setState(() {});
                                                }
                                                return;
                                              }

                                              context.pushNamed(
                                                'criacaoVolume',
                                                queryParameters: {
                                                  'fazId': serializeParam(
                                                    widget.fazId,
                                                    ParamType.int,
                                                  ),
                                                  'oservId': serializeParam(
                                                    widget.oservId,
                                                    ParamType.int,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey:
                                                      const TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType:
                                                        PageTransitionType.fade,
                                                    duration: Duration(
                                                        milliseconds: 0),
                                                  ),
                                                },
                                              );

                                              if (shouldSetState) {
                                                setState(() {});
                                              }
                                            },
                                            text: '',
                                            icon: FaIcon(
                                              FontAwesomeIcons.boxes,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              size: 28.0,
                                            ),
                                            options: FFButtonOptions(
                                              width: 60.0,
                                              height: 60.0,
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 0.0, 0.0, 0.0),
                                              iconPadding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: Colors.white,
                                                      ),
                                              elevation: 3.0,
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                            ),
                                          ),
                                      ].divide(const SizedBox(width: 10.0)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total de pontos: ${widget.listaJsonPontos?.length.toString()}',
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                  ),
                                  Text(
                                    'Pontos coletados: ${functions.pontosASemreColetadosTrSinc(widget.oservId?.toString(), widget.fazId?.toString(), FFAppState().trSincroniza.toList())}',
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            if (true == false)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 10.0, 0.0, 30.0),
                                child: Builder(
                                  builder: (context) {
                                    final pontosLista =
                                        widget.listaJsonPontos!.toList();
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children:
                                          List.generate(pontosLista.length,
                                              (pontosListaIndex) {
                                        final pontosListaItem =
                                            pontosLista[pontosListaIndex];
                                        return Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: () {
                                              if (functions
                                                      .contadorDeIntensNaLista(
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
                                              color: const Color(0xFFE6F1F0),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              border: Border.all(
                                                color: const Color(0xFF7BB3B6),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      4.0),
                                                          child: Text(
                                                            'Ponto: ${getJsonField(
                                                              pontosListaItem,
                                                              r'''$.pont_numero''',
                                                            ).toString()}',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Outfit',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      24.0,
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
                                                              width: double
                                                                  .infinity,
                                                              height: 100.0,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color(
                                                                    0x00FFFFFF),
                                                              ),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
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
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Readex Pro',
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              fontSize: 16.0,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Builder(
                                                                              builder: (context) {
                                                                                final profundidadesLista2 = getJsonField(
                                                                                  pontosListaItem,
                                                                                  r'''$.profundidades''',
                                                                                ).toList();
                                                                                return Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: List.generate(profundidadesLista2.length, (profundidadesLista2Index) {
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
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Readex Pro',
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              fontSize: 16.0,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Builder(
                                                                              builder: (context) {
                                                                                final profundidadesLista2 = getJsonField(
                                                                                  pontosListaItem,
                                                                                  r'''$.profundidades''',
                                                                                ).toList();
                                                                                return Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: List.generate(profundidadesLista2.length, (profundidadesLista2Index) {
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
                                                                                  }).divide(const SizedBox(height: 6.0)),
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
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Readex Pro',
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              fontSize: 16.0,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            4.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                          children: [
                                                                            Builder(
                                                                              builder: (context) {
                                                                                final listaFotos = getJsonField(
                                                                                  pontosListaItem,
                                                                                  r'''$.profundidades''',
                                                                                ).toList();
                                                                                return Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: List.generate(listaFotos.length, (listaFotosIndex) {
                                                                                    final listaFotosItem = listaFotos[listaFotosIndex];
                                                                                    return InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        var shouldSetState = false;
                                                                                        if (getJsonField(
                                                                                              listaFotosItem,
                                                                                              r'''$.pprof_id''',
                                                                                            ) !=
                                                                                            null) {
                                                                                          _model.temnetouno = await actions.checkinternet();
                                                                                          shouldSetState = true;
                                                                                          if (_model.temnetouno != true) {
                                                                                            await showDialog(
                                                                                              context: context,
                                                                                              builder: (alertDialogContext) {
                                                                                                return AlertDialog(
                                                                                                  title: const Text('Ops!'),
                                                                                                  content: const Text('Ative a internet para ver a foto.'),
                                                                                                  actions: [
                                                                                                    TextButton(
                                                                                                      onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                      child: const Text('Entendi'),
                                                                                                    ),
                                                                                                  ],
                                                                                                );
                                                                                              },
                                                                                            );
                                                                                            if (shouldSetState) setState(() {});
                                                                                            return;
                                                                                          }
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
                                                                                              if (shouldSetState) setState(() {});
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
                                                                                                        child: FotoColetaWidgethtmlWidget(
                                                                                                          base64: '',
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
                                                                                                          html: functions.pesquisaFotoBas64HTML(
                                                                                                              getJsonField(
                                                                                                                listaFotosItem,
                                                                                                                r'''$.pprof_id''',
                                                                                                              ).toString(),
                                                                                                              FFAppState().PontosColetados.toList(),
                                                                                                              FFAppState().PontosInacessiveis.toList(),
                                                                                                              functions.buscaRegistro(widget.fazId!, widget.oservId!, FFAppState().trSincroniza.toList())),
                                                                                                        ),
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                ).then((value) => safeSetState(() {}));

                                                                                                if (shouldSetState) setState(() {});
                                                                                                return;
                                                                                              }
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
                                                                                            if (shouldSetState) setState(() {});
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

                                                                                          if (shouldSetState) setState(() {});
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
                                                                                          if (shouldSetState) setState(() {});
                                                                                          return;
                                                                                        }

                                                                                        if (shouldSetState) setState(() {});
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
                      Builder(
                        builder: (context) {
                          final pageViewListaPontos =
                              widget.listaJsonPontos!.toList();
                          return SizedBox(
                            width: double.infinity,
                            height: 704.0,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 40.0),
                                  child: PageView.builder(
                                    controller: _model.pageViewController ??=
                                        PageController(
                                            initialPage: min(
                                                0,
                                                pageViewListaPontos.length -
                                                    1)),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: pageViewListaPontos.length,
                                    itemBuilder:
                                        (context, pageViewListaPontosIndex) {
                                      final pageViewListaPontosItem =
                                          pageViewListaPontos[
                                              pageViewListaPontosIndex];
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            pageViewListaPontosIndex.toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 30.0),
                                            child: Builder(
                                              builder: (context) {
                                                final pontosLista = functions
                                                        .listaPaginacao(
                                                            widget
                                                                .listaJsonPontos
                                                                ?.toList(),
                                                            pageViewListaPontosIndex)
                                                        ?.toList() ??
                                                    [];
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: List.generate(
                                                      pontosLista.length,
                                                      (pontosListaIndex) {
                                                    final pontosListaItem =
                                                        pontosLista[
                                                            pontosListaIndex];
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  0.0,
                                                                  16.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: () {
                                                          if (functions
                                                                  .contadorDeIntensNaLista(
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              const Color(0xFFE6F1F0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          border: Border.all(
                                                            color: const Color(
                                                                0xFF7BB3B6),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      8.0,
                                                                      0.0,
                                                                      8.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          4.0),
                                                                      child:
                                                                          Text(
                                                                        'Ponto: ${getJsonField(
                                                                          pontosListaItem,
                                                                          r'''$.pont_numero''',
                                                                        ).toString()}',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Outfit',
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              fontSize: 24.0,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            10.0,
                                                                            6.0,
                                                                            10.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              100.0,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            color:
                                                                                Color(0x00FFFFFF),
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    'Profundidade',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Readex Pro',
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                          fontSize: 16.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Builder(
                                                                                          builder: (context) {
                                                                                            final profundidadesLista2 = getJsonField(
                                                                                              pontosListaItem,
                                                                                              r'''$.profundidades''',
                                                                                            ).toList();
                                                                                            return Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: List.generate(profundidadesLista2.length, (profundidadesLista2Index) {
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
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Text(
                                                                                    'Situação',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Readex Pro',
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                          fontSize: 16.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Builder(
                                                                                          builder: (context) {
                                                                                            final profundidadesLista2 = getJsonField(
                                                                                              pontosListaItem,
                                                                                              r'''$.profundidades''',
                                                                                            ).toList();
                                                                                            return Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              children: List.generate(profundidadesLista2.length, (profundidadesLista2Index) {
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
                                                                                              }).divide(const SizedBox(height: 6.0)),
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                                children: [
                                                                                  Text(
                                                                                    'Foto',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'Readex Pro',
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                          fontSize: 16.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                                                      children: [
                                                                                        Builder(
                                                                                          builder: (context) {
                                                                                            final listaFotos = getJsonField(
                                                                                              pontosListaItem,
                                                                                              r'''$.profundidades''',
                                                                                            ).toList();
                                                                                            return Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                                              children: List.generate(listaFotos.length, (listaFotosIndex) {
                                                                                                final listaFotosItem = listaFotos[listaFotosIndex];
                                                                                                return InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    var shouldSetState = false;
                                                                                                    if (getJsonField(
                                                                                                          listaFotosItem,
                                                                                                          r'''$.pprof_id''',
                                                                                                        ) !=
                                                                                                        null) {
                                                                                                      _model.temnetounao = await actions.checkinternet();
                                                                                                      shouldSetState = true;
                                                                                                      if (_model.temnetounao != true) {
                                                                                                        await showDialog(
                                                                                                          context: context,
                                                                                                          builder: (alertDialogContext) {
                                                                                                            return AlertDialog(
                                                                                                              title: const Text('Ops!'),
                                                                                                              content: const Text('Ative a internet para ver a foto.'),
                                                                                                              actions: [
                                                                                                                TextButton(
                                                                                                                  onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                                  child: const Text('Entendi'),
                                                                                                                ),
                                                                                                              ],
                                                                                                            );
                                                                                                          },
                                                                                                        );
                                                                                                        if (shouldSetState) setState(() {});
                                                                                                        return;
                                                                                                      }
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
                                                                                                          if (shouldSetState) setState(() {});
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
                                                                                                                    child: FotoColetaWidgethtmlWidget(
                                                                                                                      base64: '',
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
                                                                                                                      html: functions.pesquisaFotoBas64HTML(
                                                                                                                          getJsonField(
                                                                                                                            listaFotosItem,
                                                                                                                            r'''$.pprof_id''',
                                                                                                                          ).toString(),
                                                                                                                          FFAppState().PontosColetados.toList(),
                                                                                                                          FFAppState().PontosInacessiveis.toList(),
                                                                                                                          functions.buscaRegistro(widget.fazId!, widget.oservId!, FFAppState().trSincroniza.toList())),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                );
                                                                                                              },
                                                                                                            ).then((value) => safeSetState(() {}));

                                                                                                            if (shouldSetState) setState(() {});
                                                                                                            return;
                                                                                                          }
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
                                                                                                        if (shouldSetState) setState(() {});
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

                                                                                                      if (shouldSetState) setState(() {});
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
                                                                                                      if (shouldSetState) setState(() {});
                                                                                                      return;
                                                                                                    }

                                                                                                    if (shouldSetState) setState(() {});
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
                                                  }).divide(
                                                      const SizedBox(height: 10.0)),
                                                );
                                              },
                                            ),
                                          ),
                                          Text(
                                            'Hello World',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(-1.0, 1.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 0.0, 16.0),
                                    child: smooth_page_indicator
                                        .SmoothPageIndicator(
                                      controller: _model.pageViewController ??=
                                          PageController(
                                              initialPage: min(
                                                  0,
                                                  pageViewListaPontos.length -
                                                      1)),
                                      count: pageViewListaPontos.length,
                                      axisDirection: Axis.horizontal,
                                      onDotClicked: (i) async {
                                        await _model.pageViewController!
                                            .animateToPage(
                                          i,
                                          duration: const Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                      },
                                      effect: smooth_page_indicator
                                          .ExpandingDotsEffect(
                                        expansionFactor: 3.0,
                                        spacing: 8.0,
                                        radius: 16.0,
                                        dotWidth: 16.0,
                                        dotHeight: 8.0,
                                        dotColor: FlutterFlowTheme.of(context)
                                            .accent1,
                                        activeDotColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        paintStyle: PaintingStyle.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
