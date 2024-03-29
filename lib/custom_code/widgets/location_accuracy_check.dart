// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationAccuracyCheck extends StatefulWidget {
  const LocationAccuracyCheck({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<LocationAccuracyCheck> createState() => _LocationAccuracyCheckState();
}

class _LocationAccuracyCheckState extends State<LocationAccuracyCheck> {
  double? _accuracy;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _determinePosition();
    // Atualiza a precisão da localização a cada 2 segundos
    _timer =
        Timer.periodic(Duration(seconds: 2), (Timer t) => _determinePosition());
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela o Timer quando o widget for destruído
    super.dispose();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifique se os serviços de localização estão habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Os serviços de localização não estão habilitados, não é possível continuar
      // Não force a ativação dos serviços de localização, mostre uma mensagem para o usuário
      return Future.error('Os serviços de localização estão desabilitados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissões negadas, não é possível continuar
        return Future.error('Permissões de localização negadas.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissões negadas permanentemente, não é possível continuar
      return Future.error(
          'Permissões de localização permanentemente negadas, não podemos solicitar permissões.');
    }

    // Quando chegamos aqui, as permissões estão concedidas e podemos continuar
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _accuracy = position.accuracy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _accuracy == null
            ? Text(
                'Carregando precisão...',
                style: TextStyle(
                  color: Colors.white, // Cor do texto
                  fontWeight: FontWeight.bold, // Negrito
                  fontSize: 18, // Tamanho do texto
                ),
              )
            : Text(
                'Precisão do GPS: ${_accuracy?.toStringAsFixed(2)} metros',
                style: TextStyle(
                  color: Colors.white, // Cor do texto
                  fontWeight: FontWeight.bold, // Negrito
                  fontSize: 18, // Tamanho do texto
                ),
              ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
