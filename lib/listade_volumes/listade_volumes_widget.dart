import '/components/foto_volume_widget.dart';
import '/components/no_volume_found_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'listade_volumes_model.dart';
export 'listade_volumes_model.dart';

class ListadeVolumesWidget extends StatefulWidget {
  const ListadeVolumesWidget({
    super.key,
    required this.oservId,
    required this.fazId,
  });

  final int? oservId;
  final int? fazId;

  @override
  State<ListadeVolumesWidget> createState() => _ListadeVolumesWidgetState();
}

class _ListadeVolumesWidgetState extends State<ListadeVolumesWidget> {
  late ListadeVolumesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListadeVolumesModel());

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
      setState(() {
        _model.emptystring = <String, String?>{
          'teste': '',
        };
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
                        'Lista de Volumes',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Outfit',
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
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
                        if (true == false)
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
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
                                          width: 50.0,
                                          height: 50.0,
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
                                    ].divide(const SizedBox(width: 5.0)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 8.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total de volumes: ${valueOrDefault<String>(
                                  functions
                                      .buscaListaDeVolumes(
                                          functions.buscaRegistro(
                                              widget.fazId!,
                                              widget.oservId!,
                                              FFAppState()
                                                  .trSincroniza
                                                  .toList()))
                                      ?.length
                                      .toString(),
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
                              final volumesListados = functions
                                      .buscaListaDeVolumes(
                                          functions.buscaRegistro(
                                              widget.fazId!,
                                              widget.oservId!,
                                              FFAppState()
                                                  .trSincroniza
                                                  .toList()))
                                      ?.toList() ??
                                  [];
                              if (volumesListados.isEmpty) {
                                return const Center(
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 170.0,
                                    child: NoVolumeFoundWidget(),
                                  ),
                                );
                              }
                              return SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children:
                                      List.generate(volumesListados.length,
                                          (volumesListadosIndex) {
                                    final volumesListadosItem =
                                        volumesListados[volumesListadosIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          valueOrDefault<double>(
                                            getJsonField(
                                                      volumesListadosItem,
                                                      r'''$.volume_data_hora_fim''',
                                                    ) !=
                                                    getJsonField(
                                                      _model.emptystring,
                                                      r'''$.teste''',
                                                    )
                                                ? 16.0
                                                : 26.0,
                                            0.0,
                                          ),
                                          0.0,
                                          16.0,
                                          0.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 170.0,
                                        decoration: BoxDecoration(
                                          color: getJsonField(
                                                    volumesListadosItem,
                                                    r'''$.volume_data_hora_fim''',
                                                  ) !=
                                                  getJsonField(
                                                    _model.emptystring,
                                                    r'''$.teste''',
                                                  )
                                              ? const Color(0xFFE6F1F0)
                                              : const Color(0xFFFFF4CE),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 0.0,
                                              color: getJsonField(
                                                        volumesListadosItem,
                                                        r'''$.volume_data_hora_fim''',
                                                      ) !=
                                                      getJsonField(
                                                        _model.emptystring,
                                                        r'''$.teste''',
                                                      )
                                                  ? const Color(0x00FFAB00)
                                                  : const Color(0xFFFFAB00),
                                              offset: const Offset(-10.0, 0.0),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: getJsonField(
                                                      volumesListadosItem,
                                                      r'''$.volume_data_hora_fim''',
                                                    ) !=
                                                    getJsonField(
                                                      _model.emptystring,
                                                      r'''$.teste''',
                                                    )
                                                ? const Color(0xFF7BB3B6)
                                                : const Color(0xFFFFAB00),
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 8.0, 0.0, 8.0),
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
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  14.0,
                                                                  0.0,
                                                                  14.0,
                                                                  4.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Volume: ${getJsonField(
                                                              volumesListadosItem,
                                                              r'''$.volume_id''',
                                                            ).toString()} (${valueOrDefault<String>(
                                                              functions
                                                                  .contadorDeNumeroDeAmostras(
                                                                      getJsonField(
                                                                volumesListadosItem,
                                                                r'''$.amostras[:].volam_etiqueta_id''',
                                                              ).toString()),
                                                              'Erro#nãotemNumero',
                                                            )} amostras)',
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
                                                                          .w600,
                                                                ),
                                                          ),
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
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          FotoVolumeWidget(
                                                                        base64:
                                                                            getJsonField(
                                                                          volumesListadosItem,
                                                                          r'''$.foto''',
                                                                        ).toString(),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .perm_media_sharp,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              size: 32.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  14.0,
                                                                  0.0,
                                                                  14.0,
                                                                  0.0),
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                1.0,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0x00E6F1F0),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Row(
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
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            2.0),
                                                                        child:
                                                                            Text(
                                                                          'Iniciado em  ${functions.formatardatahora(getJsonField(
                                                                            volumesListadosItem,
                                                                            r'''$.volume_data_hora_inicio''',
                                                                          ).toString())}',
                                                                          style:
                                                                              FlutterFlowTheme.of(context).bodyMedium,
                                                                        ),
                                                                      ),
                                                                      if (getJsonField(
                                                                            volumesListadosItem,
                                                                            r'''$.volume_data_hora_fim''',
                                                                          ) !=
                                                                          getJsonField(
                                                                            _model.emptystring,
                                                                            r'''$.teste''',
                                                                          ))
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              2.0),
                                                                          child:
                                                                              Text(
                                                                            'Concluído em ${functions.formatardatahora(getJsonField(
                                                                              volumesListadosItem,
                                                                              r'''$.volume_data_hora_fim''',
                                                                            ).toString())}',
                                                                            style:
                                                                                FlutterFlowTheme.of(context).bodyMedium,
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                1.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      14.0,
                                                                      6.0,
                                                                      14.0,
                                                                      0.0),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 68.0,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color(
                                                                  0x00FFFFFF),
                                                            ),
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    1.0, 0.0),
                                                            child: Align(
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      1.0, 0.0),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            8.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    if (getJsonField(
                                                                          volumesListadosItem,
                                                                          r'''$.lacre''',
                                                                        ) !=
                                                                        getJsonField(
                                                                          _model
                                                                              .emptystring,
                                                                          r'''$.teste''',
                                                                        ))
                                                                      Flexible(
                                                                        child:
                                                                            Align(
                                                                          alignment: const AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                'Lacre',
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Readex Pro',
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                      fontSize: 16.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                    ),
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      getJsonField(
                                                                                        volumesListadosItem,
                                                                                        r'''$.lacre''',
                                                                                      ).toString(),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    if (true ==
                                                                        false)
                                                                      Flexible(
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              'Etiqueta',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Readex Pro',
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    fontSize: 16.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Text(
                                                                                    '01949001 ',
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    if (getJsonField(
                                                                          volumesListadosItem,
                                                                          r'''$.volume_data_hora_fim''',
                                                                        ) !=
                                                                        getJsonField(
                                                                          _model
                                                                              .emptystring,
                                                                          r'''$.teste''',
                                                                        ))
                                                                      Expanded(
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              'Tempo Total',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Readex Pro',
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    fontSize: 16.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                                children: [
                                                                                  Text(
                                                                                    valueOrDefault<String>(
                                                                                      functions.diferencaEntreDatas(
                                                                                          getJsonField(
                                                                                            volumesListadosItem,
                                                                                            r'''$.volume_data_hora_inicio''',
                                                                                          ).toString(),
                                                                                          getJsonField(
                                                                                            volumesListadosItem,
                                                                                            r'''$.volume_data_hora_fim''',
                                                                                          ).toString()),
                                                                                      'erro',
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    Flexible(
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                const AlignmentDirectional(1.0, 0.0),
                                                                            child:
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                context.pushNamed(
                                                                                  'ListadeAmostras',
                                                                                  queryParameters: {
                                                                                    'fazId': serializeParam(
                                                                                      widget.fazId,
                                                                                      ParamType.int,
                                                                                    ),
                                                                                    'oservId': serializeParam(
                                                                                      widget.oservId,
                                                                                      ParamType.int,
                                                                                    ),
                                                                                    'amostras': serializeParam(
                                                                                      functions.inverterLista((getJsonField(
                                                                                        volumesListadosItem,
                                                                                        r'''$.amostras[:].volam_etiqueta_id''',
                                                                                        true,
                                                                                      ) as List)
                                                                                          .map<String>((s) => s.toString())
                                                                                          .toList()),
                                                                                      ParamType.String,
                                                                                      true,
                                                                                    ),
                                                                                    'idDoVolume': serializeParam(
                                                                                      getJsonField(
                                                                                        volumesListadosItem,
                                                                                        r'''$.volume_id''',
                                                                                      ).toString(),
                                                                                      ParamType.String,
                                                                                    ),
                                                                                    'coletadoEmList': serializeParam(
                                                                                      functions.inverterLista((getJsonField(
                                                                                        volumesListadosItem,
                                                                                        r'''$.amostras[:].volam_data''',
                                                                                        true,
                                                                                      ) as List)
                                                                                          .map<String>((s) => s.toString())
                                                                                          .toList()),
                                                                                      ParamType.String,
                                                                                      true,
                                                                                    ),
                                                                                  }.withoutNulls,
                                                                                  extra: <String, dynamic>{
                                                                                    kTransitionInfoKey: const TransitionInfo(
                                                                                      hasTransition: true,
                                                                                      transitionType: PageTransitionType.rightToLeft,
                                                                                      duration: Duration(milliseconds: 800),
                                                                                    ),
                                                                                  },
                                                                                );
                                                                              },
                                                                              child: FaIcon(
                                                                                FontAwesomeIcons.arrowCircleRight,
                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                size: 32.0,
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
                                ),
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
