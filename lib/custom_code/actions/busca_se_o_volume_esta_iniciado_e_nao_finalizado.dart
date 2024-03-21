// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:camera/camera.dart';
import 'dart:convert';

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

Future<bool> buscaSeOVolumeEstaIniciadoENaoFinalizado(
    BuildContext context, dynamic trSinc) async {
  if (trSinc['etapas'] != null && trSinc['etapas'].isNotEmpty) {
    for (var etapa in trSinc['etapas']) {
      if (etapa['etap_fim'] == null || etapa['etap_fim'].isEmpty) {
        if (etapa['volumes'] != null && etapa['volumes'].isNotEmpty) {
          var ultimoVolume = etapa['volumes'].last;
          if (ultimoVolume['volume_data_hora_fim'] == null ||
              ultimoVolume['volume_data_hora_fim'].isEmpty) {
            return true; // Existe uma etapa não finalizada com um volume não finalizado
          }

          // Se o último volume está finalizado, cria um novo volume
          var foto = await capturaImagemCameraTraseira();

          if (foto != null) {
            var proximoVolumeId = etapa['volumes'].length + 1;
            etapa['volumes'].add({
              "volume_id": proximoVolumeId,
              "foto": foto,
              "volume_data_hora_inicio":
                  DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
              "volume_data_hora_fim": "",
              "lacre": "",
              "amostras": [],
              "sincronizado": "S",
            });

            return true;
          } else {
            return false;
          }
        } else {
          // se não existem volumes, criamos um novo
          var foto = await capturaImagemCameraTraseira();
          if (foto != null) {
            etapa['volumes'].add({
              "volume_id": 1,
              "foto": foto,
              "volume_data_hora_inicio":
                  DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
              "volume_data_hora_fim": "",
              "lacre": "",
              "amostras": [],
              "sincronizado": "S",
            });
            return true;
          } else {
            return false;
          } // uma nova etapa foi criada, portanto, existe uma etapa não finalizada
        }
      }
    }
  }
  return false;
}

Future<String?> capturaImagemCameraTraseira() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.camera);

  if (image != null) {
    Uint8List bytes = await image.readAsBytes();
    img.Image? originalImage = img.decodeImage(bytes);

    if (originalImage != null) {
      // Reduzindo a imagem para 33% da qualidade original
      int width = (originalImage.width * 0.33).round();
      int height = (originalImage.height * 0.33).round();

      img.Image resizedImage =
          img.copyResize(originalImage, width: width, height: height);
      Uint8List resizedBytes =
          Uint8List.fromList(img.encodeJpg(resizedImage, quality: 33));

      // Convertendo para base64
      String base64Image = base64Encode(resizedBytes);
      return base64Image;
    }
  }
  return null; // Retorna nulo se a imagem não for capturada ou houver algum erro
}
