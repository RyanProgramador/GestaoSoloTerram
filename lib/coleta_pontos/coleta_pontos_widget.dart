import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    bool? autoAuditoria,
    required this.quantidadeAutoAuditoria,
  }) : autoAuditoria = autoAuditoria ?? false;

  final int? oservID;
  final int? fazid;
  final String? fazNome;
  final LatLng? fazLatlng;
  final bool autoAuditoria;
  final int? quantidadeAutoAuditoria;

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
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

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
                          fazLatlng: widget.fazLatlng?.toString(),
                          autoAuditoria: widget.autoAuditoria.toString(),
                          quantidadeAutoAuditoria:
                              widget.quantidadeAutoAuditoria?.toString(),
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
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              'Faltam X Coletas',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-0.88, -0.45),
                            child: Icon(
                              Icons.arrow_back_sharp,
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              size: 38.0,
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
