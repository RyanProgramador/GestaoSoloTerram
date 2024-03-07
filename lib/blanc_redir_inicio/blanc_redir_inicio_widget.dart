import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'blanc_redir_inicio_model.dart';
export 'blanc_redir_inicio_model.dart';

class BlancRedirInicioWidget extends StatefulWidget {
  const BlancRedirInicioWidget({super.key});

  @override
  State<BlancRedirInicioWidget> createState() => _BlancRedirInicioWidgetState();
}

class _BlancRedirInicioWidgetState extends State<BlancRedirInicioWidget> {
  late BlancRedirInicioModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BlancRedirInicioModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
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
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0x00F1F4F8),
      body: const Column(
        mainAxisSize: MainAxisSize.max,
        children: [],
      ),
    );
  }
}
