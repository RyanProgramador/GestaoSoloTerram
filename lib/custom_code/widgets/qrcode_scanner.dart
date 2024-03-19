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

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../criacao_volume/criacao_volume_model.dart';
export '../../criacao_volume/criacao_volume_model.dart';

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
  late CriacaoVolumeModel _model;

  QRViewController? controller;
  String qrText = '';
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    controller?.dispose();
    textController.dispose();
    super.dispose();
  }

  void showSincro() {
    List<dynamic> trSincComS = FFAppState()
        .trSincroniza
        .where((element) =>
            element['fazenda_id'] == 1 && element['servico_id'] == 1)
        .map((e) => e["etapas"])
        .toList()
        .first;
    var volumess = trSincComS
        .map((e) => e["volumes"])
        //     .where((element) =>
        // element["volumes"] == "" || element["volumes"] == null)
        .toList()
        .first;
    showDialog(
      context: context,
      builder: (BuildContext context) {
/*preciso criar uma forma de criar um volume quando entra nessa tela, oq preciso fazer,
preciso antes do botão me mandar para essa tela, preciso fazer uma validação, "existe volume criado?
 se não, eu crio um volume usando o codigo acima de ffappstate.trsinc[etapas][volumes]
 para add uma list {id,foto,lacre,amostras (qr-codes lidos), sincronizado = S, datahorainicio, datahora fim}
  após criar isso, adicionar verificar a lista, pois a lista sera necesario criar um novo appstate para
   comportar lista de amostas, ou eu listo a profundiade e ponto atraves da etiqueta usando custom function,
   clicou em finalizar, fecha tudo usando o datahorafim para notar que tem um finalizado
    */
        return AlertDialog(
          title: Text('Concluído!'),
          content: Text(volumess.toString()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 85,
          top: -5,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  20), // Aplica bordas arredondadas ao Container
              color: Colors
                  .black, // Cor de fundo, pode ser transparente ou qualquer cor desejada
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  20), // Aplica bordas arredondadas ao conteúdo do Container
              child: SizedBox(
                width: 100,
                height: 100,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Color(0xFFFFFFFF),
                    borderRadius: 2,
                    borderLength: 30,
                    borderWidth: 10,
                    overlayColor: Color(0xDB000000),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 6,
          left: 0,
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Código',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: TextFormField(
                        controller: textController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: '',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF00736d),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF00736d),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      FFAppState().teste.add(textController.text);
                      textController.clear();
                    },
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                    backgroundColor: Color(0xFF00736d),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 92,
          left: 10,
          child: FloatingActionButton(
            onPressed: () {
              // controller?.resumeCamera();
              // textController.clear();
              showSincro();
            },
            child: Icon(Icons.delete, color: Colors.white),
            backgroundColor: Color(0xFF982c26),
          ),
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code!;
        // FFAppState().teste.add(qrText);
        controller?.pauseCamera();
        // FFAppState().numeroVolumeQrCode = qrText;
        // context.goNamed('criacaoVolume',);
        textController.text = scanData.code!;
        // Potentially perform an action based on the scanned QR code
        print('Scanned QR code: $qrText'); // Example action: log to console
      });
    });
  }
}
