// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:modest_pagination/modest_pagination.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/foto_coleta_widget_widget.dart';
import '/components/foto_coleta_widgethtml_widget.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '../../lista_pontos/lista_pontos_model.dart';
export '../../lista_pontos/lista_pontos_model.dart';

class ListPaginacaoWidget extends StatefulWidget {
  const ListPaginacaoWidget({
    super.key,
    this.width,
    this.height,
    this.trPontos,
    this.fazId,
    this.oservId,
  });

  final double? width;
  final double? height;
  final List<dynamic>? trPontos;
  final int? fazId;
  final int? oservId;

  @override
  State<ListPaginacaoWidget> createState() => _ListPaginacaoWidgetState();
}

class _ListPaginacaoWidgetState extends State<ListPaginacaoWidget> {
  late ListaPontosModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  int itemsPerPage = 20;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListaPontosModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget conteinerComOsPontos(dynamic pontosLista) {
    final pontosListaItem = pontosLista[0];
    return // Generated code for this Container Widget...
        Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
      child: Container(
        width: double.infinity,
        height: () {
          if (functions.contadorDeIntensNaLista(getJsonField(
                pontosListaItem,
                r'''$.profundidades''',
                true,
              )) ==
              4) {
            return 190.0;
          } else if (functions.contadorDeIntensNaLista(getJsonField(
                pontosListaItem,
                r'''$.profundidades''',
                true,
              )) ==
              3) {
            return 170.0;
          } else if (functions.contadorDeIntensNaLista(getJsonField(
                pontosListaItem,
                r'''$.profundidades''',
                true,
              )) ==
              2) {
            return 150.0;
          } else if (functions.contadorDeIntensNaLista(getJsonField(
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
          color: Color(0xFFE6F1F0),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Color(0xFF7BB3B6),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                      child: Text(
                        'Ponto: ${getJsonField(
                          pontosListaItem,
                          r'''$.pont_numero''',
                        ).toString()}',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Outfit',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 6.0, 10.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: Color(0x00FFFFFF),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Profundidade',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 4.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Builder(
                                          builder: (context) {
                                            final profundidadesLista2 =
                                                getJsonField(
                                              pontosListaItem,
                                              r'''$.profundidades''',
                                            ).toList();
                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                  profundidadesLista2.length,
                                                  (profundidadesLista2Index) {
                                                final profundidadesLista2Item =
                                                    profundidadesLista2[
                                                        profundidadesLista2Index];
                                                return Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      height: 20.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0x00FFFFFF),
                                                      ),
                                                      child: Container(
                                                        width: 18.0,
                                                        height: 20.0,
                                                        child: custom_widgets
                                                            .IconeComLegenda(
                                                          width: 18.0,
                                                          height: 20.0,
                                                          lista: FFAppState()
                                                              .trIcones,
                                                          termoDePesquisa:
                                                              getJsonField(
                                                            profundidadesLista2Item,
                                                            r'''$.pprof_icone''',
                                                          ).toString(),
                                                          pathDePesquisa:
                                                              'ico_valor',
                                                          pathDeRetorno:
                                                              'ico_base64',
                                                          pathDeLegenda:
                                                              'ico_legenda',
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  4.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          functions
                                                              .retornalegenda(
                                                                  getJsonField(
                                                                    profundidadesLista2Item,
                                                                    r'''$.pprof_icone''',
                                                                  ).toString(),
                                                                  FFAppState()
                                                                      .trIcones
                                                                      .toList()),
                                                          'Erro',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w200,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }).divide(SizedBox(height: 4.0)),
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
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 4.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Builder(
                                          builder: (context) {
                                            final profundidadesLista2 =
                                                getJsonField(
                                              pontosListaItem,
                                              r'''$.profundidades''',
                                            ).toList();
                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  profundidadesLista2.length,
                                                  (profundidadesLista2Index) {
                                                final profundidadesLista2Item =
                                                    profundidadesLista2[
                                                        profundidadesLista2Index];
                                                return Text(
                                                  valueOrDefault<String>(
                                                    functions
                                                        .pesquisaParaVerSeOPontoFoiColetado(
                                                            getJsonField(
                                                              profundidadesLista2Item,
                                                              r'''$.pprof_id''',
                                                            ),
                                                            FFAppState()
                                                                .PontosColetados
                                                                .toList(),
                                                            FFAppState()
                                                                .PontosInacessiveis
                                                                .toList(),
                                                            functions.buscaRegistro(
                                                                widget.fazId!,
                                                                widget.oservId!,
                                                                FFAppState()
                                                                    .trSincroniza
                                                                    .toList())),
                                                    'Ops!',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        fontWeight:
                                                            FontWeight.w200,
                                                      ),
                                                );
                                              }).divide(SizedBox(height: 6.0)),
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
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 4.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: List.generate(
                                                  listaFotos.length,
                                                  (listaFotosIndex) {
                                                final listaFotosItem =
                                                    listaFotos[listaFotosIndex];
                                                return InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    var _shouldSetState = false;
                                                    if (getJsonField(
                                                          listaFotosItem,
                                                          r'''$.pprof_id''',
                                                        ) !=
                                                        null) {
                                                      _model.temnetouno =
                                                          await actions
                                                              .checkinternet();
                                                      _shouldSetState = true;
                                                      if (_model.temnetouno !=
                                                          true) {
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return AlertDialog(
                                                              title:
                                                                  Text('Ops!'),
                                                              content: Text(
                                                                  'Ative a internet para ver a foto.'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Entendi'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                        if (_shouldSetState)
                                                          setState(() {});
                                                        return;
                                                      }
                                                      if (functions
                                                              .pesquisaFotoBas64(
                                                                  getJsonField(
                                                                    listaFotosItem,
                                                                    r'''$.pprof_id''',
                                                                  ).toString(),
                                                                  FFAppState()
                                                                      .PontosColetados
                                                                      .toList(),
                                                                  FFAppState()
                                                                      .PontosInacessiveis
                                                                      .toList()) !=
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
                                                            builder:
                                                                (alertDialogContext) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Ops!'),
                                                                content: Text(
                                                                    'Não foi capturada foto para essa coleta!'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext),
                                                                    child: Text(
                                                                        'Entendi'),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                          if (_shouldSetState)
                                                            setState(() {});
                                                          return;
                                                        }
                                                      } else {
                                                        if (functions
                                                                    .pesquisaFotoBas64HTML(
                                                                        getJsonField(
                                                                          listaFotosItem,
                                                                          r'''$.pprof_id''',
                                                                        )
                                                                            .toString(),
                                                                        FFAppState()
                                                                            .PontosColetados
                                                                            .toList(),
                                                                        FFAppState()
                                                                            .PontosInacessiveis
                                                                            .toList(),
                                                                        functions.buscaRegistro(
                                                                            widget
                                                                                .fazId!,
                                                                            widget
                                                                                .oservId!,
                                                                            FFAppState()
                                                                                .trSincroniza
                                                                                .toList())) !=
                                                                null &&
                                                            functions
                                                                    .pesquisaFotoBas64HTML(
                                                                        getJsonField(
                                                                          listaFotosItem,
                                                                          r'''$.pprof_id''',
                                                                        )
                                                                            .toString(),
                                                                        FFAppState()
                                                                            .PontosColetados
                                                                            .toList(),
                                                                        FFAppState()
                                                                            .PontosInacessiveis
                                                                            .toList(),
                                                                        functions.buscaRegistro(
                                                                            widget.fazId!,
                                                                            widget.oservId!,
                                                                            FFAppState().trSincroniza.toList())) !=
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
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              enableDrag: false,
                                                              context: context,
                                                              builder:
                                                                  (context) {
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
                                                                  child:
                                                                      Padding(
                                                                    padding: MediaQuery
                                                                        .viewInsetsOf(
                                                                            context),
                                                                    child:
                                                                        FotoColetaWidgethtmlWidget(
                                                                      base64:
                                                                          '',
                                                                      marcadorNomeIdPontoNumero:
                                                                          getJsonField(
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
                                                            ).then((value) =>
                                                                safeSetState(
                                                                    () {}));
                                                            if (_shouldSetState)
                                                              setState(() {});
                                                            return;
                                                          }
                                                        }
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return AlertDialog(
                                                              title:
                                                                  Text('Ops!'),
                                                              content: Text(
                                                                  'Não existe imagem capturada para essa coleta.'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Fechar'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                        if (_shouldSetState)
                                                          setState(() {});
                                                        return;
                                                      }
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
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
                                                                    .requestFocus(
                                                                        _model
                                                                            .unfocusNode)
                                                                : FocusScope.of(
                                                                        context)
                                                                    .unfocus(),
                                                            child: Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child:
                                                                  FotoColetaWidgetWidget(
                                                                base64: functions
                                                                    .pesquisaFotoBas64(
                                                                        getJsonField(
                                                                          listaFotosItem,
                                                                          r'''$.pprof_id''',
                                                                        )
                                                                            .toString(),
                                                                        FFAppState()
                                                                            .PontosColetados
                                                                            .toList(),
                                                                        FFAppState()
                                                                            .PontosInacessiveis
                                                                            .toList())!,
                                                                marcadorNomeIdPontoNumero:
                                                                    getJsonField(
                                                                  pontosListaItem,
                                                                  r'''$.pont_numero''',
                                                                ).toString(),
                                                                profundidade: functions
                                                                    .retornalegenda(
                                                                        getJsonField(
                                                                          listaFotosItem,
                                                                          r'''$.pprof_icone''',
                                                                        )
                                                                            .toString(),
                                                                        FFAppState()
                                                                            .trIcones
                                                                            .toList())!,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          safeSetState(() {}));
                                                      if (_shouldSetState)
                                                        setState(() {});
                                                      return;
                                                    } else {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return AlertDialog(
                                                            title: Text('Ops!'),
                                                            content: Text(
                                                                'Erro na variavel.'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext),
                                                                child:
                                                                    Text('Ok'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                      if (_shouldSetState)
                                                        setState(() {});
                                                      return;
                                                    }
                                                    if (_shouldSetState)
                                                      setState(() {});
                                                  },
                                                  child: FaIcon(
                                                    FontAwesomeIcons.images,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 21.0,
                                                  ),
                                                );
                                              }).divide(SizedBox(height: 2.0)),
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
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> paginatedItems = widget.trPontos!;
    print(widget.trPontos!.length);
    var mostraOuNao = 40.0;
    if (widget.trPontos!.length > 120) {
      mostraOuNao = 40.0;
    } else {
      mostraOuNao = 0.0;
    }

    return ModestPagination(
      items: paginatedItems,
      itemsPerPage: itemsPerPage,
      activeTextColor: Color.fromRGBO(0, 115, 109, 1),
      inactiveTextColor: Color.fromRGBO(205, 205, 205, 1),
      pagesControllerIconsColor: Color.fromRGBO(0, 115, 109, 1),
      sheetsControllerIconsColor: Color.fromRGBO(0, 115, 109, 1),
      pagesControllerIconsSize: 40.0,
      sheetsControllerIconsSize: mostraOuNao,
      useListView: true,
      childWidget: (dynamic element) {
        return conteinerComOsPontos(
            [element]); // Ajuste para passar o elemento como uma lista
      },
    );
  }
}
