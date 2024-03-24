// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:qr_code_scanner/qr_code_scanner.dart';

Future<String?> leitorDeQrCode(BuildContext context) async {
  String? scannedResult;
  QRViewController? controller;

  await Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(
        title: Text(
          'Ler qr code do lacre do volume',
          softWrap: true,
          overflow: TextOverflow.visible,
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Color(0xFF025959),
      ),
      body: QRView(
        key: GlobalKey(debugLabel: 'QR'),
        onQRViewCreated: (QRViewController qrController) {
          controller = qrController;
          qrController.scannedDataStream.listen((scanData) async {
            scannedResult = scanData.code;
            qrController
                .pauseCamera(); // Pausa a câmera para mostrar a confirmação

            bool confirm = await etiquetaConfirmation(context, scannedResult);
            if (confirm) {
              Navigator.of(context)
                  .pop(scannedResult); // Retorna o QR Code lido
            } else {
              qrController.resumeCamera(); // Retoma a leitura do QR Code
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

  controller?.dispose(); // Garante a liberação do recurso da câmera
  return scannedResult ?? "-1";
}

Future<bool> etiquetaConfirmation(
    BuildContext context, String? etiqueta) async {
  return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Atenção!!'),
            content: Text(
                'Identificamos O lacre de número $etiqueta. Deseja confirmar?'),
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
