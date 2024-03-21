import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'criacao_volume_model.dart';
export 'criacao_volume_model.dart';

class CriacaoVolumeWidget extends StatefulWidget {
  const CriacaoVolumeWidget({
    super.key,
    required this.fazId,
    required this.oservId,
  });

  final int? fazId;
  final int? oservId;

  @override
  State<CriacaoVolumeWidget> createState() => _CriacaoVolumeWidgetState();
}

class _CriacaoVolumeWidgetState extends State<CriacaoVolumeWidget> {
  late CriacaoVolumeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CriacaoVolumeModel());

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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            var shouldSetState = false;
            var confirmDialogResponse = await showDialog<bool>(
                  context: context,
                  builder: (alertDialogContext) {
                    return AlertDialog(
                      title: const Text('Atenção!'),
                      content:
                          const Text('Você deseja realmente fechar esse volume?'),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(alertDialogContext, false),
                          child: const Text('Não'),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(alertDialogContext, true),
                          child: const Text('Sim'),
                        ),
                      ],
                    );
                  },
                ) ??
                false;
            if (confirmDialogResponse) {
              _model.qrCode = await FlutterBarcodeScanner.scanBarcode(
                '#C62828', // scanning line color
                'Cancel', // cancel button text
                true, // whether to show the flash icon
                ScanMode.QR,
              );

              shouldSetState = true;
              if ((_model.qrCode != '') &&
                  (_model.qrCode != '-1')) {
                _model.finalizacaoDeVolume =
                    await actions.buscaSeOVolumeEstaIniciadoEFinalizaEle(
                  context,
                  functions.buscaRegistro(widget.fazId!, widget.oservId!,
                      FFAppState().trSincroniza.toList()),
                  _model.qrCode,
                );
                shouldSetState = true;
                if (_model.finalizacaoDeVolume!) {
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
                  if (shouldSetState) setState(() {});
                  return;
                }
              } else {
                if (shouldSetState) setState(() {});
                return;
              }
            }
            if (shouldSetState) setState(() {});
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          icon: const Icon(
            Icons.check,
          ),
          elevation: 8.0,
          label: Text(
            'Finalizar',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: Colors.white,
                ),
          ),
        ),
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
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
                      'Escaneie os qr-codes',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Outfit',
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    if (true)
                      Text(
                        'Para criar o volume, leia todos os qr-codes!',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
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
              child: Align(
                alignment: const AlignmentDirectional(0.0, -1.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0x00FFFFFF),
                  ),
                  child: Align(
                    alignment: const AlignmentDirectional(0.0, -1.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 14.0, 16.0, 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Container(
                                width: double.infinity,
                                height: 350.0,
                                decoration: BoxDecoration(
                                  color: const Color(0x0000736D),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: custom_widgets.QrcodeScanner(
                                    width: double.infinity,
                                    height: double.infinity,
                                    oservid: widget.oservId?.toString(),
                                    fazId: widget.fazId?.toString(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Amostras lidas: ${valueOrDefault<String>(
                                  functions
                                      .buscaVolumesNoRegistro(
                                          functions.buscaRegistro(
                                              widget.fazId!,
                                              widget.oservId!,
                                              FFAppState()
                                                  .trSincroniza
                                                  .toList()))
                                      .length
                                      .toString(),
                                  '0',
                                )}',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: const Color(0xFF00736D),
                                    ),
                              ),
                              Container(
                                width: double.infinity,
                                height: MediaQuery.sizeOf(context).height * 0.3,
                                decoration: const BoxDecoration(),
                                child: Builder(
                                  builder: (context) {
                                    final teste = functions
                                        .buscaVolumesNoRegistro(
                                            functions.buscaRegistro(
                                                widget.fazId!,
                                                widget.oservId!,
                                                FFAppState()
                                                    .trSincroniza
                                                    .toList()))
                                        .toList();
                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: List.generate(teste.length,
                                            (testeIndex) {
                                          final testeItem = teste[testeIndex];
                                          return Container(
                                            width: double.infinity,
                                            height: 65.0,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFE6F1F0),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 0.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Ponto',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                      ),
                                                      Text(
                                                        valueOrDefault<String>(
                                                          functions.buscaPontoAtravesDaEtiquetaEmPontos(
                                                              functions.buscaRegistro(
                                                                  widget.fazId!,
                                                                  widget
                                                                      .oservId!,
                                                                  FFAppState()
                                                                      .trSincroniza
                                                                      .toList()),
                                                              testeItem,
                                                              widget.fazId,
                                                              widget.oservId),
                                                          '11111',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Profundidade',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                    Text(
                                                      valueOrDefault<String>(
                                                        functions
                                                            .retornalegenda(
                                                                valueOrDefault<
                                                                    String>(
                                                                  functions.buscalegendaiconeAtravesDaEtiquetaEmPontosCopy(
                                                                      functions.buscaRegistro(
                                                                          widget
                                                                              .fazId!,
                                                                          widget
                                                                              .oservId!,
                                                                          FFAppState()
                                                                              .trSincroniza
                                                                              .toList()),
                                                                      testeItem,
                                                                      widget
                                                                          .fazId,
                                                                      widget
                                                                          .oservId),
                                                                  'error32',
                                                                ),
                                                                FFAppState()
                                                                    .trIcones
                                                                    .toList()),
                                                        'Erro',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium,
                                                    ),
                                                    if (true == false)
                                                      Text(
                                                        valueOrDefault<String>(
                                                          functions.buscalegendaiconeAtravesDaEtiquetaEmPontosCopy(
                                                              functions.buscaRegistro(
                                                                  widget.fazId!,
                                                                  widget
                                                                      .oservId!,
                                                                  FFAppState()
                                                                      .trSincroniza
                                                                      .toList()),
                                                              testeItem,
                                                              widget.fazId,
                                                              widget.oservId),
                                                          'error32',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    if (true == false)
                                                      Text(
                                                        valueOrDefault<String>(
                                                          functions.buscapprofidAtravesDaEtiquetaEmPontos(
                                                              functions.buscaRegistro(
                                                                  widget.fazId!,
                                                                  widget
                                                                      .oservId!,
                                                                  FFAppState()
                                                                      .trSincroniza
                                                                      .toList()),
                                                              testeItem),
                                                          'erro',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Etiqueta',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                    Text(
                                                      testeItem,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium,
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 10.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    8.0,
                                                                    0.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            var shouldSetState =
                                                                false;
                                                            var confirmDialogResponse =
                                                                await showDialog<
                                                                        bool>(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (alertDialogContext) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text('Atenção!'),
                                                                          content:
                                                                              const Text('Você tem certeza que deseja remover essa amostra de dentro do volume?'),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                              child: const Text('Não'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                              child: const Text('Sim'),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    ) ??
                                                                    false;
                                                            if (confirmDialogResponse) {
                                                              _model.retornoEclusao =
                                                                  actions
                                                                      .excluiVolumeDaEtapaAberta(
                                                                functions.buscaRegistro(
                                                                    widget
                                                                        .fazId!,
                                                                    widget
                                                                        .oservId!,
                                                                    FFAppState()
                                                                        .trSincroniza
                                                                        .toList()),
                                                                testeItem,
                                                              );
                                                              shouldSetState =
                                                                  true;
                                                              await showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (alertDialogContext) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        _model
                                                                            .retornoEclusao!),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.pop(alertDialogContext),
                                                                        child: const Text(
                                                                            'Ok'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            } else {
                                                              if (shouldSetState) {
                                                                setState(() {});
                                                              }
                                                              return;
                                                            }

                                                            if (shouldSetState) {
                                                              setState(() {});
                                                            }
                                                          },
                                                          child: const FaIcon(
                                                            FontAwesomeIcons
                                                                .trashAlt,
                                                            color: Colors.black,
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).divide(const SizedBox(height: 5.0)),
                                      ),
                                    );
                                  },
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
          ],
        ),
      ),
    );
  }
}
