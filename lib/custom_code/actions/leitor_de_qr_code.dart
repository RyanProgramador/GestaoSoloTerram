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

Future<String> leitorDeQrCode(BuildContext context) async {
  // Add your function code here!

  String? scannedResult;

  await Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(
        title: Text('Leitor de QR Code'),
        backgroundColor: Color(0xFF025959),
      ),
      body: QRView(
        key: GlobalKey(debugLabel: 'QR'),
        onQRViewCreated: (QRViewController controller) {
          controller.scannedDataStream.listen((scanData) {
            scannedResult = scanData.code;
            Navigator.of(context)
                .pop(); // Fecha a tela de leitura após capturar o QR code
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

  return scannedResult! ?? "-1"; // Retorna o conteúdo do QR Code lido
}
