import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
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
    required this.trPontos,
  }) : autoAuditoria = autoAuditoria ?? false;

  final int? oservID;
  final int? fazid;
  final String? fazNome;
  final LatLng? fazLatlng;
  final bool autoAuditoria;
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
                                context.safePop();
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
