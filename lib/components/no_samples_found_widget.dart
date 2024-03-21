import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'no_samples_found_model.dart';
export 'no_samples_found_model.dart';

class NoSamplesFoundWidget extends StatefulWidget {
  const NoSamplesFoundWidget({super.key});

  @override
  State<NoSamplesFoundWidget> createState() => _NoSamplesFoundWidgetState();
}

class _NoSamplesFoundWidgetState extends State<NoSamplesFoundWidget> {
  late NoSamplesFoundModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoSamplesFoundModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170.0,
      constraints: const BoxConstraints(
        maxWidth: 300.0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F1F0),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primary,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
              child: Text(
                'Ops!',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
              child: Text(
                'Nenhuma amostra encontrada!',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      fontSize: 16.0,
                    ),
              ),
            ),
            Icon(
              Icons.no_sim_outlined,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
