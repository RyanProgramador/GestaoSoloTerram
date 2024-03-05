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

import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrcodeScanner extends StatefulWidget {
  const QrcodeScanner({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<QrcodeScanner> createState() => _QrcodeScannerState();
}

class _QrcodeScannerState extends State<QrcodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = '';

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200, // Set a desired width for the scanner
        height: 200, // Set a desired height for the scanner
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: Color(0xFF00736D),
            borderRadius: 10,
            borderLength: 130,
            borderWidth: 5,
            overlayColor: Colors.white,
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code!;
        // Potentially perform an action based on the scanned QR code
        print('Scanned QR code: $qrText'); // Example action: log to console
      });
    });
  }
}
