import '/flutter_flow/flutter_flow_util.dart';
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
  });

  final String? tipo;
  final String? fazNome;
  final String? data;
  final String? observacao;
  final LatLng? fazlatlng;
  final String? fazCidade;
  final String? fazEstado;
  final int? servico;

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
      await Future.delayed(const Duration(milliseconds: 2000));
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
        }.withoutNulls,
      );
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
    );
  }
}
