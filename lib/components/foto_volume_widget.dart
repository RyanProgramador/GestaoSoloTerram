import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'foto_volume_model.dart';
export 'foto_volume_model.dart';

class FotoVolumeWidget extends StatefulWidget {
  const FotoVolumeWidget({
    super.key,
    this.base64,
  });

  final String? base64;

  @override
  State<FotoVolumeWidget> createState() => _FotoVolumeWidgetState();
}

class _FotoVolumeWidgetState extends State<FotoVolumeWidget> {
  late FotoVolumeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FotoVolumeModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20.0, 100.0, 20.0, 200.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: const [
              BoxShadow(
                blurRadius: 3.0,
                color: Color(0x33000000),
                offset: Offset(0.0, 1.0),
              )
            ],
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: FlutterFlowTheme.of(context).alternate,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 12.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14.0),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 200.0,
                                    child: custom_widgets.FotoBase64(
                                      width: double.infinity,
                                      height: 200.0,
                                      base64Foto: widget.base64,
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
            ],
          ),
        ),
      ),
    );
  }
}
