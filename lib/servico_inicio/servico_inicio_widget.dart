import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';
import 'servico_inicio_model.dart';
export 'servico_inicio_model.dart';

class ServicoInicioWidget extends StatefulWidget {
  const ServicoInicioWidget({
    super.key,
    required this.fazLatLng,
    required this.fazNome,
    required this.estadoFaz,
    required this.cidadeFaz,
    required this.data,
    required this.observacao,
    required this.servico,
    required this.fazId,
  });

  final LatLng? fazLatLng;
  final String? fazNome;
  final String? estadoFaz;
  final String? cidadeFaz;
  final String? data;
  final String? observacao;
  final int? servico;
  final int? fazId;

  @override
  State<ServicoInicioWidget> createState() => _ServicoInicioWidgetState();
}

class _ServicoInicioWidgetState extends State<ServicoInicioWidget> {
  late ServicoInicioModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ServicoInicioModel());
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(22.0),
                bottomRight: Radius.circular(22.0),
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
              ),
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 200.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(22.0),
                    bottomRight: Radius.circular(22.0),
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0),
                  ),
                ),
                child: Stack(
                  children: [
                    Builder(builder: (context) {
                      final googleMapMarker = widget.fazLatLng;
                      return FlutterFlowGoogleMap(
                        controller: _model.googleMapsController,
                        onCameraIdle: (latLng) =>
                            _model.googleMapsCenter = latLng,
                        initialLocation: _model.googleMapsCenter ??=
                            widget.fazLatLng!,
                        markers: [
                          if (googleMapMarker != null)
                            FlutterFlowMarker(
                              googleMapMarker.serialize(),
                              googleMapMarker,
                            ),
                        ],
                        markerColor: GoogleMarkerColor.violet,
                        mapType: MapType.satellite,
                        style: GoogleMapStyle.standard,
                        initialZoom: 14.0,
                        allowInteraction: false,
                        allowZoom: false,
                        showZoomControls: false,
                        showLocation: false,
                        showCompass: false,
                        showMapToolbar: false,
                        showTraffic: false,
                        centerMapOnMarkerTap: false,
                      );
                    }),
                    Align(
                      alignment: const AlignmentDirectional(-0.9, -0.47),
                      child: PointerInterceptor(
                        intercepting: isWeb,
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
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
                          },
                          child: Icon(
                            Icons.arrow_back_sharp,
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            size: 38.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                width: double.infinity,
                height: 100.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 100.0,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              valueOrDefault<String>(
                                widget.fazNome,
                                'Fazenda',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Outfit',
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            if (valueOrDefault<bool>(
                                  valueOrDefault<String>(
                                            widget.estadoFaz,
                                            'Estado',
                                          ) !=
                                          '',
                                  false,
                                ) &&
                                valueOrDefault<bool>(
                                  widget.cidadeFaz != null &&
                                      widget.cidadeFaz != '',
                                  false,
                                ))
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '${widget.cidadeFaz}, ${widget.estadoFaz}',
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                  ),
                                ],
                              ),
                            if ((valueOrDefault<String>(
                                          widget.estadoFaz,
                                          'Estado',
                                        ) ==
                                        '') ||
                                (widget.cidadeFaz == null ||
                                    widget.cidadeFaz == ''))
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    valueOrDefault<String>(
                                      functions
                                          .latlngToString(widget.fazLatLng),
                                      '1',
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Observação',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                            ),
                            Text(
                              valueOrDefault<String>(
                                widget.observacao,
                                '...',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (true == false)
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: double.infinity,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                      ),
                    if (true == false)
                      Expanded(
                        flex: 6,
                        child: Container(
                          width: double.infinity,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                        ),
                      ),
                    Container(
                      width: double.infinity,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              _model.trPontos =
                                  await TrOsServicosGroup.trPontosCall.call(
                                urlApi: FFAppState().UrlApi,
                                servicoId: widget.servico,
                              );
                              if (TrOsServicosGroup.trPontosCall
                                  .statusTrBuscaPontos(
                                (_model.trPontos?.jsonBody ?? ''),
                              )!) {
                                context.pushNamed(
                                  'listaPontos',
                                  queryParameters: {
                                    'listaJsonPontos': serializeParam(
                                      TrOsServicosGroup.trPontosCall
                                          .dadosTrBuscaPontos(
                                        (_model.trPontos?.jsonBody ?? ''),
                                      ),
                                      ParamType.JSON,
                                      true,
                                    ),
                                    'oservId': serializeParam(
                                      widget.servico,
                                      ParamType.int,
                                    ),
                                    'fazId': serializeParam(
                                      widget.fazId,
                                      ParamType.int,
                                    ),
                                    'fazNome': serializeParam(
                                      widget.fazNome,
                                      ParamType.String,
                                    ),
                                    'fazLatlng': serializeParam(
                                      widget.fazLatLng,
                                      ParamType.LatLng,
                                    ),
                                    'autoAuditoria': serializeParam(
                                      false,
                                      ParamType.bool,
                                    ),
                                    'quantidadeAutoAuditoria': serializeParam(
                                      1,
                                      ParamType.int,
                                    ),
                                  }.withoutNulls,
                                );
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: const Text('Ops!'),
                                      content: Text(getJsonField(
                                        (_model.trPontos?.jsonBody ?? ''),
                                        r'''$.message''',
                                      ).toString()),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: const Text('Fechar'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }

                              setState(() {});
                            },
                            text: 'Coletas',
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 0.5,
                              height: 45.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
