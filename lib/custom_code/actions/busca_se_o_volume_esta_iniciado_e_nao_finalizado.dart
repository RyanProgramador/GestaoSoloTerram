// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:camera/camera.dart';
import 'dart:convert';

Future<bool> buscaSeOVolumeEstaIniciadoENaoFinalizado(
    BuildContext context, dynamic trSinc) async {
  if (trSinc['etapas'] != null && trSinc['etapas'].isNotEmpty) {
    for (var etapa in trSinc['etapas']) {
      if (etapa['etap_fim'] == null || etapa['etap_fim'].isEmpty) {
        if (etapa['volumes'] != null && etapa['volumes'].isNotEmpty) {
          for (var volume in etapa['volumes']) {
            if (volume['volume_data_hora_fim'] == null ||
                volume['volume_data_hora_fim'].isEmpty) {
              return true; // existe uma etapa não finalizada com um volume não finalizado
            }
          }
        } else {
          // se não existem volumes, criamos um novo
          var foto = await capturaImagemCameraTraseira(context);

          etapa['volumes'].add({
            "volume_id": 1,
            "foto": foto,
            "volume_data_hora_inicio": DateTime.now().toIso8601String(),
            "volume_data_hora_fim": "",
            "lacre": "",
            "amostras": [],
            "sincronizado": "N",
          });
          return true; // uma nova etapa foi criada, portanto, existe uma etapa não finalizada
        }
      }
    }
  }
  return false;
}

Future<String?> capturaImagemCameraTraseira(BuildContext context) async {
  // Inicia as câmeras
  List<CameraDescription> cameras = await availableCameras();

  // Pega a câmera frontal
  CameraDescription frontCamera = cameras.firstWhere(
    (camera) => camera.lensDirection == CameraLensDirection.back,
    orElse: () => cameras.first,
  );

  // Inicia o controlador da câmera
  CameraController controller =
      CameraController(frontCamera, ResolutionPreset.medium);
  try {
    // Inicializa o controlador da câmera
    await controller.initialize();

    // Variável para armazenar o base64 da imagem
    String? base64Image;

    // Mostra o preview da câmera ocupando a tela inteira
    await showDialog(
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text('Bater Ponto'),
          backgroundColor: Color(0xFF025959),
          centerTitle: true,
        ),
        body: Container(
          color: Color(0xFF025959),
          child: Stack(
            fit: StackFit.loose,
            children: [
              Positioned.fill(
                bottom: MediaQuery.of(context).size.height *
                    0.23, // Adjust this value as needed
                child: CameraPreview(controller),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height *
                    0.08, // Adjust this value as needed
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final image = await controller.takePicture();
                      if (image != null) {
                        final imageBytes = await image.readAsBytes();
                        base64Image = base64Encode(imageBytes);
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                    ),
                    child: Icon(Icons.camera_alt, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return base64Image; // Retorna o base64 da imagem capturada
  } catch (e) {
    // Lidar com erros, se houver
    print('Erro ao inicializar a câmera: $e');
  } finally {
    await controller.dispose();
  }
}
