// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class ColetaPontos extends StatefulWidget {
  const ColetaPontos({
    super.key,
    this.width,
    this.height,
    this.oservid,
    this.fazId,
    this.fazNome,
    this.fazLatlng,
    this.autoAuditoria,
    this.quantidadeAutoAuditoria,
  });

  final double? width;
  final double? height;
  final String? oservid;
  final String? fazId;
  final String? fazNome;
  final LatLng? fazLatlng;
  final String? autoAuditoria;
  final String? quantidadeAutoAuditoria;

  @override
  State<ColetaPontos> createState() => _ColetaPontosState();
}

class _ColetaPontosState extends State<ColetaPontos> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
