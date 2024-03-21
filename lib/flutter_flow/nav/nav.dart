import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => appStateNotifier.showSplashImage
          ? Builder(
              builder: (context) => Container(
                color: const Color(0xFF00736D),
                child: Center(
                  child: Image.asset(
                    'assets/images/splash.png',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          : const LoginWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.showSplashImage
              ? Builder(
                  builder: (context) => Container(
                    color: const Color(0xFF00736D),
                    child: Center(
                      child: Image.asset(
                        'assets/images/splash.png',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : const LoginWidget(),
        ),
        FFRoute(
          name: 'Inicio',
          path: '/inicio',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'Inicio')
              : const InicioWidget(),
        ),
        FFRoute(
          name: 'Alertas',
          path: '/alertas',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'Alertas')
              : const AlertasWidget(),
        ),
        FFRoute(
          name: 'AjustesConfiguracoes',
          path: '/ajustesConfiguracoes',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'AjustesConfiguracoes')
              : const AjustesConfiguracoesWidget(),
        ),
        FFRoute(
          name: 'ServicoInicio',
          path: '/servicoInicio',
          builder: (context, params) => ServicoInicioWidget(
            fazLatLng: params.getParam('fazLatLng', ParamType.LatLng),
            fazNome: params.getParam('fazNome', ParamType.String),
            estadoFaz: params.getParam('estadoFaz', ParamType.String),
            cidadeFaz: params.getParam('cidadeFaz', ParamType.String),
            data: params.getParam('data', ParamType.String),
            observacao: params.getParam('observacao', ParamType.String),
            servico: params.getParam('servico', ParamType.int),
            fazId: params.getParam('fazId', ParamType.int),
            localizacao: params.getParam('localizacao', ParamType.String),
            autoAuditoria: params.getParam('autoAuditoria', ParamType.bool),
            quantiadeDeFotosParaIntervalo:
                params.getParam('quantiadeDeFotosParaIntervalo', ParamType.int),
          ),
        ),
        FFRoute(
          name: 'listaPontos',
          path: '/listaPontos',
          builder: (context, params) => ListaPontosWidget(
            listaJsonPontos: params.getParam<dynamic>(
                'listaJsonPontos', ParamType.JSON, true),
            oservId: params.getParam('oservId', ParamType.int),
            fazId: params.getParam('fazId', ParamType.int),
            fazNome: params.getParam('fazNome', ParamType.String),
            fazLatlng: params.getParam('fazLatlng', ParamType.LatLng),
            autoAuditoria: params.getParam('autoAuditoria', ParamType.bool),
            quantidadeAutoAuditoria:
                params.getParam('quantidadeAutoAuditoria', ParamType.int),
          ),
        ),
        FFRoute(
          name: 'ColetaPontos',
          path: '/coletaPontos',
          builder: (context, params) => ColetaPontosWidget(
            oservID: params.getParam('oservID', ParamType.int),
            fazid: params.getParam('fazid', ParamType.int),
            fazNome: params.getParam('fazNome', ParamType.String),
            fazLatlng: params.getParam('fazLatlng', ParamType.LatLng),
            autoAuditoria: params.getParam('autoAuditoria', ParamType.bool),
            quantidadeAutoAuditoria:
                params.getParam('quantidadeAutoAuditoria', ParamType.int),
            trPontos:
                params.getParam<dynamic>('trPontos', ParamType.JSON, true),
          ),
        ),
        FFRoute(
          name: 'Login',
          path: '/login',
          builder: (context, params) => const LoginWidget(),
        ),
        FFRoute(
          name: 'EsqueceuSenha',
          path: '/esqueceuSenha',
          builder: (context, params) => const EsqueceuSenhaWidget(),
        ),
        FFRoute(
          name: 'blancRedirInicio',
          path: '/blancRedirInicio',
          builder: (context, params) => const BlancRedirInicioWidget(),
        ),
        FFRoute(
          name: 'criacaoVolume',
          path: '/criacaoVolume',
          builder: (context, params) => CriacaoVolumeWidget(
            fazId: params.getParam('fazId', ParamType.int),
            oservId: params.getParam('oservId', ParamType.int),
          ),
        ),
        FFRoute(
          name: 'ListadeVolumes',
          path: '/listadeVolumes',
          builder: (context, params) => ListadeVolumesWidget(
            oservId: params.getParam('oservId', ParamType.int),
            fazId: params.getParam('fazId', ParamType.int),
          ),
        ),
        FFRoute(
          name: 'ListadeAmostras',
          path: '/listadeAmostras',
          builder: (context, params) => ListadeAmostrasWidget(
            fazId: params.getParam('fazId', ParamType.int),
            oservId: params.getParam('oservId', ParamType.int),
            amostras:
                params.getParam<String>('amostras', ParamType.String, true),
            idDoVolume: params.getParam('idDoVolume', ParamType.String),
            coletadoEmList: params.getParam<String>(
                'coletadoEmList', ParamType.String, true),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouter.of(context).location;
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}
