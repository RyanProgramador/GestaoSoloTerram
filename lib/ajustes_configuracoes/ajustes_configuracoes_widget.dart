import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ajustes_configuracoes_model.dart';
export 'ajustes_configuracoes_model.dart';

class AjustesConfiguracoesWidget extends StatefulWidget {
  const AjustesConfiguracoesWidget({super.key});

  @override
  State<AjustesConfiguracoesWidget> createState() =>
      _AjustesConfiguracoesWidgetState();
}

class _AjustesConfiguracoesWidgetState
    extends State<AjustesConfiguracoesWidget> {
  late AjustesConfiguracoesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AjustesConfiguracoesModel());
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
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Configurações',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Divider(
                  thickness: 1.0,
                  color: FlutterFlowTheme.of(context).primary,
                ),
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Em desenvolvimento',
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                              if (true == true)
                                Builder(
                                  builder: (context) {
                                    final sINC =
                                        FFAppState().trSincroniza.toList();
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(sINC.length,
                                          (sINCIndex) {
                                        final sINCItem = sINC[sINCIndex];
                                        return SelectionArea(
                                            child: Text(
                                          sINCItem.toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                        ));
                                      }),
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 125.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        setState(() {
                          FFAppState().trTalhoesEmCadaServico = [];
                          FFAppState().dadosTrBuscaPontosLista = [];
                          FFAppState().PontosTotalmenteColetados = [];
                          FFAppState().listaColetasInciadas = [];
                          FFAppState().tecnicoid = 0;
                          FFAppState().trSincroniza = [];
                          FFAppState().PontosInacessiveis = [];
                          FFAppState().PontosColetados = [];
                          FFAppState().trTalhoes = [];
                          FFAppState().trIcones = [];
                          FFAppState().trOsServicos = [];
                          FFAppState().naoLista = jsonDecode(
                              '{\"fazenda_id\":2,\"servico_id\":10,\"pontos\":[{\"id\":381,\"status\":1,\"obs\":\"quando ponto inacessível precisa de obs\",\"foto\":\"quando ponto inacessível precisa de foto\",\"profundidades\":[{\"id\":1,\"status\":1,\"obs\":\"opcional\",\"foto\":\"conforme auditoria\",\"data\":\"2024-02-24 08:00\"}]},{\"id\":382,\"status\":1,\"obs\":\"\",\"foto\":\"base64\",\"profundidades\":[{\"id\":1,\"status\":1,\"obs\":\"\",\"foto\":\"\",\"data\":\"2024-02-24 08:00\"}]},{\"id\":383,\"status\":1,\"obs\":\"\",\"foto\":\"base64\",\"profundidades\":[{\"id\":1,\"status\":1,\"obs\":\"\",\"foto\":\"\",\"data\":\"2024-02-24 08:00\"}]}]}');
                          FFAppState().login = '';
                          FFAppState().senha = '';
                          FFAppState().diadoUltimoAcesso = null;
                        });

                        context.goNamed(
                          'Login',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 600),
                            ),
                          },
                        );
                      },
                      text: 'Sair',
                      options: FFButtonOptions(
                        width: 90.0,
                        height: 42.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: const Color(0xFF9D291C),
                        textStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).alternate,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
                        elevation: 3.0,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
