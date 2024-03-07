import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'loading_model.dart';
export 'loading_model.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({
    super.key,
    required this.tipo,
    required this.fazNome,
    required this.data,
    required this.observacao,
    required this.fazlatlng,
    required this.fazCidade,
    required this.fazEstado,
    required this.servico,
    required this.fazID,
    required this.fazlocalizacao,
    required this.autoAuditoria,
    required this.quantidadeDeIntervaloDeFotosAutoAuditoria,
  });

  final String? tipo;
  final String? fazNome;
  final String? data;
  final String? observacao;
  final LatLng? fazlatlng;
  final String? fazCidade;
  final String? fazEstado;
  final int? servico;
  final int? fazID;
  final String? fazlocalizacao;
  final bool? autoAuditoria;
  final int? quantidadeDeIntervaloDeFotosAutoAuditoria;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  late LoadingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.tipo == 'Coleta') {
        await Future.delayed(const Duration(milliseconds: 2000));
      }
      _model.temNet = await actions.checkinternet();
      if (!_model.temNet!) {
        if (functions.buscaRegistro(widget.fazID!, widget.servico!,
                FFAppState().trSincroniza.toList()) !=
            null) {
          Navigator.pop(context);

          context.pushNamed(
            'ServicoInicio',
            queryParameters: {
              'fazLatLng': serializeParam(
                widget.fazlatlng,
                ParamType.LatLng,
              ),
              'fazNome': serializeParam(
                widget.fazNome,
                ParamType.String,
              ),
              'estadoFaz': serializeParam(
                widget.fazEstado,
                ParamType.String,
              ),
              'cidadeFaz': serializeParam(
                widget.fazCidade,
                ParamType.String,
              ),
              'data': serializeParam(
                widget.data,
                ParamType.String,
              ),
              'observacao': serializeParam(
                widget.observacao,
                ParamType.String,
              ),
              'servico': serializeParam(
                widget.servico,
                ParamType.int,
              ),
              'fazId': serializeParam(
                widget.fazID,
                ParamType.int,
              ),
              'localizacao': serializeParam(
                widget.fazlocalizacao,
                ParamType.String,
              ),
              'autoAuditoria': serializeParam(
                widget.autoAuditoria,
                ParamType.bool,
              ),
              'quantiadeDeFotosParaIntervalo': serializeParam(
                widget.quantidadeDeIntervaloDeFotosAutoAuditoria,
                ParamType.int,
              ),
            }.withoutNulls,
            extra: <String, dynamic>{
              kTransitionInfoKey: const TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
                duration: Duration(milliseconds: 0),
              ),
            },
          );
        } else {
          Navigator.pop(context);
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: const Text('Ops!'),
                content: const Text(
                    'Parece que é sua primeira vez no serviço, necessário sincronizar '),
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

        return;
      }
      _model.trPontos = await TrOsServicosGroup.trPontosCall.call(
        urlApi: FFAppState().UrlApi,
        servicoId: widget.servico,
        fazendaId: widget.fazID,
      );
      _model.trTalhaoDoServico = await TrOsServicosGroup.trTalhaoCall.call(
        urlApi: FFAppState().UrlApi,
        fazId: widget.fazID,
      );
      if (TrOsServicosGroup.trPontosCall.statusTrBuscaPontos(
        (_model.trPontos?.jsonBody ?? ''),
      )!) {
        if (functions.buscaRegistro(widget.fazID!, widget.servico!,
                FFAppState().trSincroniza.toList()) !=
            null) {
          if (functions.buscaRegistro(widget.fazID!, widget.servico!,
                  FFAppState().trTalhoesEmCadaServico.toList()) !=
              null) {
            setState(() {
              FFAppState().updateTrTalhoesEmCadaServicoAtIndex(
                valueOrDefault<int>(
                  functions.buscaRegistroIndex(widget.fazID!, widget.servico!,
                      FFAppState().trTalhoesEmCadaServico.toList()),
                  -1,
                ),
                (_) => getJsonField(
                  <String, dynamic>{
                    'fazenda_id': widget.fazID,
                    'servico_id': widget.servico,
                    'dados': getJsonField(
                      (_model.trTalhaoDoServico?.jsonBody ?? ''),
                      r'''$.dados''',
                    ),
                  },
                  r'''$''',
                ),
              );
            });
          } else {
            setState(() {
              FFAppState().addToTrTalhoesEmCadaServico(getJsonField(
                <String, dynamic>{
                  'fazenda_id': widget.fazID,
                  'servico_id': widget.servico,
                  'dados': getJsonField(
                    (_model.trTalhaoDoServico?.jsonBody ?? ''),
                    r'''$.dados''',
                  ),
                },
                r'''$''',
              ));
            });
          }
        } else {
          FFAppState().update(() {
            FFAppState().addToTrSincroniza(getJsonField(
              <String, dynamic>{
                'fazenda_id': widget.fazID!,
                'servico_id': widget.servico!,
                'pontos': getJsonField(
                  (_model.trPontos?.jsonBody ?? ''),
                  r'''$.dados''',
                ),
              },
              r'''$''',
            ));
          });
          if (functions.buscaRegistro(widget.fazID!, widget.servico!,
                  FFAppState().trTalhoesEmCadaServico.toList()) !=
              null) {
            setState(() {
              FFAppState().updateTrTalhoesEmCadaServicoAtIndex(
                valueOrDefault<int>(
                  functions.buscaRegistroIndex(widget.fazID!, widget.servico!,
                      FFAppState().trTalhoesEmCadaServico.toList()),
                  -1,
                ),
                (_) => getJsonField(
                  <String, dynamic>{
                    'fazenda_id': widget.fazID,
                    'servico_id': widget.servico,
                    'dados': getJsonField(
                      (_model.trTalhaoDoServico?.jsonBody ?? ''),
                      r'''$.dados''',
                    ),
                  },
                  r'''$''',
                ),
              );
            });
          } else {
            setState(() {
              FFAppState().addToTrTalhoesEmCadaServico(getJsonField(
                <String, dynamic>{
                  'fazenda_id': widget.fazID,
                  'servico_id': widget.servico,
                  'dados': getJsonField(
                    (_model.trTalhaoDoServico?.jsonBody ?? ''),
                    r'''$.dados''',
                  ),
                },
                r'''$''',
              ));
            });
          }

          Navigator.pop(context);
          FFAppState().update(() {
            FFAppState().trSincroniza =
                FFAppState().trSincroniza.toList().cast<dynamic>();
            FFAppState().trTalhoesEmCadaServico =
                FFAppState().trTalhoesEmCadaServico.toList().cast<dynamic>();
            FFAppState().trTalhoes =
                FFAppState().trTalhoes.toList().cast<dynamic>();
          });

          context.pushNamed(
            'ServicoInicio',
            queryParameters: {
              'fazLatLng': serializeParam(
                widget.fazlatlng,
                ParamType.LatLng,
              ),
              'fazNome': serializeParam(
                widget.fazNome,
                ParamType.String,
              ),
              'estadoFaz': serializeParam(
                widget.fazEstado,
                ParamType.String,
              ),
              'cidadeFaz': serializeParam(
                widget.fazCidade,
                ParamType.String,
              ),
              'data': serializeParam(
                widget.data,
                ParamType.String,
              ),
              'observacao': serializeParam(
                widget.observacao,
                ParamType.String,
              ),
              'servico': serializeParam(
                widget.servico,
                ParamType.int,
              ),
              'fazId': serializeParam(
                widget.fazID,
                ParamType.int,
              ),
              'localizacao': serializeParam(
                widget.fazlocalizacao,
                ParamType.String,
              ),
              'autoAuditoria': serializeParam(
                widget.autoAuditoria,
                ParamType.bool,
              ),
              'quantiadeDeFotosParaIntervalo': serializeParam(
                widget.quantidadeDeIntervaloDeFotosAutoAuditoria,
                ParamType.int,
              ),
            }.withoutNulls,
            extra: <String, dynamic>{
              kTransitionInfoKey: const TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
                duration: Duration(milliseconds: 0),
              ),
            },
          );

          return;
        }

        Navigator.pop(context);
        setState(() {
          FFAppState().trSincroniza =
              FFAppState().trSincroniza.toList().cast<dynamic>();
          FFAppState().trTalhoesEmCadaServico =
              FFAppState().trTalhoesEmCadaServico.toList().cast<dynamic>();
          FFAppState().trTalhoes =
              FFAppState().trTalhoes.toList().cast<dynamic>();
        });

        context.pushNamed(
          'ServicoInicio',
          queryParameters: {
            'fazLatLng': serializeParam(
              widget.fazlatlng,
              ParamType.LatLng,
            ),
            'fazNome': serializeParam(
              widget.fazNome,
              ParamType.String,
            ),
            'estadoFaz': serializeParam(
              widget.fazEstado,
              ParamType.String,
            ),
            'cidadeFaz': serializeParam(
              widget.fazCidade,
              ParamType.String,
            ),
            'data': serializeParam(
              widget.data,
              ParamType.String,
            ),
            'observacao': serializeParam(
              widget.observacao,
              ParamType.String,
            ),
            'servico': serializeParam(
              widget.servico,
              ParamType.int,
            ),
            'fazId': serializeParam(
              widget.fazID,
              ParamType.int,
            ),
            'localizacao': serializeParam(
              widget.fazlocalizacao,
              ParamType.String,
            ),
            'autoAuditoria': serializeParam(
              widget.autoAuditoria,
              ParamType.bool,
            ),
            'quantiadeDeFotosParaIntervalo': serializeParam(
              widget.quantidadeDeIntervaloDeFotosAutoAuditoria,
              ParamType.int,
            ),
          }.withoutNulls,
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
              content: Text(getJsonField(
                (_model.trPontos?.jsonBody ?? ''),
                r'''$.message''',
              ).toString().toString()),
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
