import '/backend/api_requests/api_calls.dart';
import '/components/password_para_u_r_l_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'login_model.dart';
export 'login_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.simna = await actions.lembrarSenha(
        getCurrentTimestamp,
        FFAppState().diadoUltimoAcesso,
      );
      if (_model.simna!) {
        _model.md5Passs2 = await actions.md5encode(
          _model.passwordLoginController.text,
        );
        _model.trLogin2 = await TrOsServicosGroup.trLoginCall.call(
          urlApi: FFAppState().UrlApi,
          usuario: FFAppState().login,
          senha: FFAppState().senha,
        );
        if (getJsonField(
          (_model.trLogin2?.jsonBody ?? ''),
          r'''$.status''',
        )) {
          setState(() {
            FFAppState().tecnicoid = getJsonField(
              (_model.trLogin?.jsonBody ?? ''),
              r'''$.tecnico_id''',
            );
          });
        } else {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: const Text('Ops!'),
                content: Text(getJsonField(
                  (_model.trLogin?.jsonBody ?? ''),
                  r'''$.message''',
                ).toString().toString()),
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

        _model.trIcones2 = await TrOsServicosGroup.triconesCall.call(
          urlApi: FFAppState().UrlApi,
        );
        if (getJsonField(
          (_model.trIcones?.jsonBody ?? ''),
          r'''$.status''',
        )) {
          setState(() {
            FFAppState().trIcones = getJsonField(
              (_model.trIcones2?.jsonBody ?? ''),
              r'''$.dados''',
              true,
            )!
                .toList()
                .cast<dynamic>();
          });
        } else {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: const Text('Ops!'),
                content: Text(getJsonField(
                  (_model.trIcones?.jsonBody ?? ''),
                  r'''$.message''',
                ).toString().toString()),
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

        context.pushNamed(
          'Inicio',
          extra: <String, dynamic>{
            kTransitionInfoKey: const TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 600),
            ),
          },
        );
      } else {
        return;
      }
    });

    _model.emailAddressLoginController ??= TextEditingController();
    _model.emailAddressLoginFocusNode ??= FocusNode();

    _model.passwordLoginController ??= TextEditingController();
    _model.passwordLoginFocusNode ??= FocusNode();
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
        backgroundColor: FlutterFlowTheme.of(context).primary,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              constraints: const BoxConstraints(
                minWidth: double.infinity,
                minHeight: double.infinity,
                maxWidth: double.infinity,
                maxHeight: double.infinity,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF14181B),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: const AlignmentDirectional(0.0, -1.0),
                  image: Image.asset(
                    'assets/images/unsplash_jin4W1HqgL4.png',
                  ).image,
                ),
              ),
              alignment: const AlignmentDirectional(0.0, -1.0),
              child: Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0x9400736D),
                  ),
                  alignment: const AlignmentDirectional(0.0, -1.0),
                  child: Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onLongPress: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () => _model
                                                  .unfocusNode.canRequestFocus
                                              ? FocusScope.of(context)
                                                  .requestFocus(
                                                      _model.unfocusNode)
                                              : FocusScope.of(context)
                                                  .unfocus(),
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: const PasswordParaURLWidget(),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  child: Image.asset(
                                    'assets/images/terram-branco.png',
                                    width: 382.0,
                                    height: 82.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 0.75,
                          decoration: const BoxDecoration(
                            color: Color(0x000C0C0C),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                44.0, 70.0, 44.0, 0.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 10.0),
                                    child: Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.62,
                                      decoration: const BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ACESSAR',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 20.0, 0.0, 0.0),
                                            child: TextFormField(
                                              controller: _model
                                                  .emailAddressLoginController,
                                              focusNode: _model
                                                  .emailAddressLoginFocusNode,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'CPF',
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                alignLabelWithHint: false,
                                                hintStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Lexend Deca',
                                                      color: const Color(0x0095A1AC),
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                filled: true,
                                                fillColor: const Color(0x005C7473),
                                                contentPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 24.0,
                                                            20.0, 24.0),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                              textAlign: TextAlign.start,
                                              maxLines: null,
                                              validator: _model
                                                  .emailAddressLoginControllerValidator
                                                  .asValidator(context),
                                              inputFormatters: [
                                                _model.emailAddressLoginMask
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 12.0, 0.0, 0.0),
                                            child: TextFormField(
                                              controller: _model
                                                  .passwordLoginController,
                                              focusNode:
                                                  _model.passwordLoginFocusNode,
                                              obscureText: !_model
                                                  .passwordLoginVisibility,
                                              decoration: InputDecoration(
                                                labelText: 'Senha',
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                alignLabelWithHint: false,
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Lexend Deca',
                                                          color: Colors.white,
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.white,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                ),
                                                filled: true,
                                                fillColor: const Color(0x00FFFFFF),
                                                contentPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 24.0,
                                                            20.0, 24.0),
                                                suffixIcon: InkWell(
                                                  onTap: () => setState(
                                                    () => _model
                                                            .passwordLoginVisibility =
                                                        !_model
                                                            .passwordLoginVisibility,
                                                  ),
                                                  focusNode: FocusNode(
                                                      skipTraversal: true),
                                                  child: Icon(
                                                    _model.passwordLoginVisibility
                                                        ? Icons
                                                            .visibility_outlined
                                                        : Icons
                                                            .visibility_off_outlined,
                                                    color: const Color(0xFFF4F4F4),
                                                    size: 20.0,
                                                  ),
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                              textAlign: TextAlign.start,
                                              validator: _model
                                                  .passwordLoginControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 20.0, 0.0, 0.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                context.pushNamed(
                                                  'EsqueceuSenha',
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        const TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                      duration: Duration(
                                                          milliseconds: 650),
                                                    ),
                                                  },
                                                );
                                              },
                                              text: 'Esqueceu a senha?',
                                              options: FFButtonOptions(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color: const Color(0x0039D2C0),
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          fontSize: 16.0,
                                                        ),
                                                elevation: 0.0,
                                                borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Align(
                                              alignment: const AlignmentDirectional(
                                                  0.0, 1.0),
                                              child: ClipRRect(
                                                child: Container(
                                                  width: double.infinity,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.1,
                                                  decoration: const BoxDecoration(),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 100.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Color(
                                                                0x00FFFFFF),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        4.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0.0),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/Rectangle_13.png',
                                                                      width:
                                                                          15.0,
                                                                      height:
                                                                          15.0,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'DESENVOLVIDO POR CONCEITTO',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          var shouldSetState =
                                                              false;
                                                          _model.md5Passs =
                                                              await actions
                                                                  .md5encode(
                                                            _model
                                                                .passwordLoginController
                                                                .text,
                                                          );
                                                          shouldSetState =
                                                              true;
                                                          _model.trLogin =
                                                              await TrOsServicosGroup
                                                                  .trLoginCall
                                                                  .call(
                                                            urlApi: FFAppState()
                                                                .UrlApi,
                                                            usuario: _model
                                                                .emailAddressLoginController
                                                                .text,
                                                            senha:
                                                                _model.md5Passs,
                                                          );
                                                          shouldSetState =
                                                              true;
                                                          if (getJsonField(
                                                            (_model.trLogin
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.status''',
                                                          )) {
                                                            setState(() {
                                                              FFAppState()
                                                                      .tecnicoid =
                                                                  getJsonField(
                                                                (_model.trLogin
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$.tecnico_id''',
                                                              );
                                                              FFAppState()
                                                                      .login =
                                                                  _model
                                                                      .emailAddressLoginController
                                                                      .text;
                                                              FFAppState()
                                                                      .senha =
                                                                  _model
                                                                      .md5Passs!;
                                                              FFAppState()
                                                                      .diadoUltimoAcesso =
                                                                  getCurrentTimestamp;
                                                            });
                                                          } else {
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      'Ops!'),
                                                                  content: Text(
                                                                      getJsonField(
                                                                    (_model.trLogin
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                    r'''$.message''',
                                                                  ).toString()),
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
                                                            if (shouldSetState) {
                                                              setState(() {});
                                                            }
                                                            return;
                                                          }

                                                          _model.trIcones =
                                                              await TrOsServicosGroup
                                                                  .triconesCall
                                                                  .call(
                                                            urlApi: FFAppState()
                                                                .UrlApi,
                                                          );
                                                          shouldSetState =
                                                              true;
                                                          if (getJsonField(
                                                            (_model.trIcones
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$.status''',
                                                          )) {
                                                            setState(() {
                                                              FFAppState()
                                                                      .trIcones =
                                                                  getJsonField(
                                                                (_model.trIcones
                                                                        ?.jsonBody ??
                                                                    ''),
                                                                r'''$.dados''',
                                                                true,
                                                              )!
                                                                      .toList()
                                                                      .cast<
                                                                          dynamic>();
                                                            });
                                                          } else {
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      'Ops!'),
                                                                  content: Text(
                                                                      getJsonField(
                                                                    (_model.trIcones
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                    r'''$.message''',
                                                                  ).toString()),
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
                                                            if (shouldSetState) {
                                                              setState(() {});
                                                            }
                                                            return;
                                                          }

                                                          context.pushNamed(
                                                            'Inicio',
                                                            extra: <String,
                                                                dynamic>{
                                                              kTransitionInfoKey:
                                                                  const TransitionInfo(
                                                                hasTransition:
                                                                    true,
                                                                transitionType:
                                                                    PageTransitionType
                                                                        .fade,
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        600),
                                                              ),
                                                            },
                                                          );

                                                          if (shouldSetState) {
                                                            setState(() {});
                                                          }
                                                        },
                                                        child: ClipOval(
                                                          child: Container(
                                                            width: 70.0,
                                                            height: 70.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: const Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .arrowRight,
                                                                color: Colors
                                                                    .white,
                                                                size: 24.0,
                                                              ),
                                                            ),
                                                          ),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
