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

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

Future<bool> buscaSeOVolumeEstaIniciadoENaoFinalizado(
    BuildContext context, dynamic trSinc) async {
  // Verifica se existem etapas e se alguma etapa está aberta
  if (trSinc['etapas'] != null) {
    for (var etapa in trSinc['etapas']) {
      if (etapa['etap_fim'] == null || etapa['etap_fim'].isEmpty) {
        // Verifica se existe algum volume aberto na etapa
        var ultimoVolume = etapa['volumes'].lastWhere(
            (v) =>
                v['volume_data_hora_fim'] == null ||
                v['volume_data_hora_fim'].isEmpty,
            orElse: () => null);
        if (ultimoVolume != null) {
          return true;
        }

        // Se todos os volumes estão fechados, solicita a criação de um novo volume
        String? foto = await capturaImagemCameraTraseira();
        String? volEtiquetaId = await leitorDeQrCode(context);

        // Confirma a etiqueta lida
        // bool confirmacao = await etiquetaConfirmation(context, volEtiquetaId);
        // if (!confirmacao) {
        //   return false; // Interrompe a operação se o usuário não confirmar a etiqueta
        // }

        if (foto != null && volEtiquetaId != null && volEtiquetaId != "-1") {
          // Adiciona o novo volume
          etapa['volumes'].add({
            "volume_id": etapa['volumes'].length + 1,
            "foto": foto,
            "volume_data_hora_inicio":
                DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()),
            "volume_data_hora_fim": "",
            "lacre": "",
            "vol_etiqueta_id": volEtiquetaId,
            "amostras": [],
            "sincronizado": "S",
          });
          return true;
        }
      }
    }
  }
  return false;
}

Future<bool> etiquetaConfirmation(
    BuildContext context, String? etiqueta) async {
  return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Atenção!!'),
            content: Text(
                'Identificamos a etiqueta de número $etiqueta. Deseja confirmar?'),
            actions: <Widget>[
              TextButton(
                child: Text("Não, ler novamente"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: Text("Sim"),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        },
      ) ??
      false;
}

Future<String?> capturaImagemCameraTraseira() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.camera);
  if (image != null) {
    Uint8List bytes = await image.readAsBytes();
    img.Image? originalImage = img.decodeImage(bytes);
    if (originalImage != null) {
      img.Image resizedImage = img.copyResize(originalImage,
          width: (originalImage.width * 0.33).round(),
          height: (originalImage.height * 0.33).round());
      Uint8List resizedBytes =
          Uint8List.fromList(img.encodeJpg(resizedImage, quality: 33));
      return base64Encode(resizedBytes);
    }
  }
  return null;
}

Future<String?> leitorDeQrCode(BuildContext context) async {
  String? scannedResult;

  bool confirm = false;
  while (!confirm) {
    // Inicia o scanner de QR Code
    scannedResult = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text('Ler QR Code da etiqueta do volume'),
          backgroundColor: Color(0xFF025959),
        ),
        body: QRView(
          key: GlobalKey(debugLabel: 'QR'),
          onQRViewCreated: (QRViewController controller) {
            controller.scannedDataStream.listen((scanData) async {
              scannedResult = scanData.code;
              controller
                  .pauseCamera(); // Pausa a câmera para aguardar confirmação

              // Solicita a confirmação da etiqueta
              confirm = await etiquetaConfirmation(context, scannedResult);
              if (confirm) {
                Navigator.of(context).pop(
                    scannedResult); // Fecha a tela de leitura após confirmar o QR Code
              } else {
                controller.resumeCamera(); // Retoma a câmera para nova leitura
              }
            });
          },
          overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: MediaQuery.of(context).size.width * 0.8,
          ),
        ),
      ),
    ));

    // Se o scanner foi cancelado ou o resultado é inválido, sai do loop
    if (scannedResult == null || scannedResult == "-1") {
      break;
    }
  }

  return scannedResult; // Retorna o resultado final do QR Code lido ou "-1" se cancelado ou inválido
}
