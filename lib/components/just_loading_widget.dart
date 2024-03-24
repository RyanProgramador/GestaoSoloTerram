import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'just_loading_model.dart';
export 'just_loading_model.dart';

class JustLoadingWidget extends StatefulWidget {
  const JustLoadingWidget({super.key});

  @override
  State<JustLoadingWidget> createState() => _JustLoadingWidgetState();
}

class _JustLoadingWidgetState extends State<JustLoadingWidget> {
  late JustLoadingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JustLoadingModel());
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
