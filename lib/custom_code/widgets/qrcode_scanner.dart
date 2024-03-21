// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../criacao_volume/criacao_volume_model.dart';
export '../../criacao_volume/criacao_volume_model.dart';

class QrcodeScanner extends StatefulWidget {
  const QrcodeScanner({
    super.key,
    this.width,
    this.height,
    this.oservid,
    this.fazId,
  });

  final double? width;
  final double? height;
  final String? oservid;
  final String? fazId;

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

  void atualiza() {
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //
    //       title: Text(''),
    //       content: SingleChildScrollView(
    //         child: Text(''),
    //       ),
    //     );
    //     },
    // );

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog from closing on tap outside
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 1, // Very small width
            height: 1, // Very small height
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
          ),
          contentPadding:
              EdgeInsets.zero, // Removes any extra padding inside the dialog
          insetPadding:
              EdgeInsets.zero, // Removes any extra padding outside the dialog
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                1), // Optional: just to make sure it's as small as possible
          ),
        );
      },
    );
  }

  void showSincro() {
    List<dynamic> trSincComS = FFAppState()
        .trSincroniza
        .where((element) =>
            element['fazenda_id'] == int.parse(widget.fazId!) &&
            element['servico_id'] == int.parse(widget.oservid!))
        .map((e) => e["pontos"])
        .toList()
        .first;
    // var pontos = trSincComS
    //     .map((e) => e["profundidades"])
    //     .where((element) =>
    // element["sincronizado"].toString() != "S" )
    //     .toList()
    // // .toString()
    //     .first;
    //     // .first;

    List<dynamic> profundidadesNaoSincronizadas = [];
    //

    List<dynamic> profundidadesNaoSincronizadas3 = [];
    for (var profIcon in trSincComS) {
      var legendaIcone = profIcon['profundidades'] as List<dynamic>;
      var legendaIconeFiltrada = legendaIcone
          .where((legendaIcone) =>
              legendaIcone['sincronizado'].toString() == "S" &&
              legendaIcone['pprof_etiqueta_id'].toString() == "1")
          .map((e) => e['pprof_id'])
          .toList();

      profundidadesNaoSincronizadas3.addAll(legendaIconeFiltrada);
    }
    var tttt = profundidadesNaoSincronizadas3.first.toString();

    List<dynamic> etiquetasSincronizadas = [];

    for (var ponto in trSincComS) {
      if (ponto['profundidades'] != null) {
        List<dynamic> profundidades = ponto['profundidades'];
        for (var profundidade in profundidades) {
          if (profundidade['pprof_id'].toString() == "29616" &&
              profundidade['sincronizado'] == "S") {
            etiquetasSincronizadas
                .add(profundidade['pprof_etiqueta_id'].toString());
          }
        }
      }
    }

    var etiquetaId = etiquetasSincronizadas.isNotEmpty
        ? etiquetasSincronizadas.first.toString()
        : null;

    // for (var profIcon in trSincComS) {
    //   var legendaIcone = profIcon['profundidades'] as List<dynamic>;
    //   var legendaIconeFiltrada = legendaIcone
    //       .where((legendaIcone) =>
    //   legendaIcone['sincronizado'].toString() == "S" &&
    //       legendaIcone['pprof_etiqueta_id'].toString() == '777')
    //       .map((e) => e['pprof_icone'])
    //       .toList();
    //
    //   profundidadesNaoSincronizadas.addAll(legendaIconeFiltrada);
    // }

    for (var ponto in trSincComS) {
      if (ponto.containsKey('pont_numero')) {
        profundidadesNaoSincronizadas.add(ponto['pont_numero']);
      }
    }

// ----------------------------------------------------
//     List<dynamic> profundidadesNaoSincronizadas = [];
//
//     for (var profIcon in trSincComS) {
//       var legendaIcone = profIcon['profundidades'] as List<dynamic>;
//       var legendaIconeFiltrada = legendaIcone
//           .where((legendaIcone) =>
//               legendaIcone['sincronizado'].toString() == "S" &&
//               legendaIcone['pprof_etiqueta_id'].toString() == '777')
//           .map((e) => e['pprof_icone'])
//           .toList();
//
//       profundidadesNaoSincronizadas.addAll(legendaIconeFiltrada);
//     }

//---------------------------------------------------------
//     List<dynamic> profundidadesNaoSincronizadas = [];
//
//     for (var ponto in trSincComS) {
//       var profundidades = ponto['profundidades'] as List<dynamic>;
//       var profundidadesFiltradas = profundidades
//           .where(
//               (profundidade) => profundidade['sincronizado'].toString() == "S")
//           .map((e) => e['pprof_etiqueta_id'])
//           .toList();
//
//       profundidadesNaoSincronizadas.addAll(profundidadesFiltradas);
//     }
//------------------------------------------------------
    List<dynamic> trSincetapas = FFAppState()
        .trSincroniza
        .where((element) =>
            element['fazenda_id'] == int.parse(widget.fazId!) &&
            element['servico_id'] == int.parse(widget.oservid!))
        .map((e) => e["etapas"])
        .toList()
        .first;
    List<dynamic> volumesNaoSincronizadas = [];
    for (var volume in trSincetapas) {
      var volumes = volume['volumes'] as List<dynamic>;
      var volumesFiltrados = volumes
          .where((volumes) =>
              volumes['volume_data_hora_fim'].toString() != "" ||
              volumes['volume_data_hora_fim'].toString() != null)
          .map((e) => e['amostras'])
          .toList()
          .first;

      volumesNaoSincronizadas.addAll(volumesFiltrados);
    }
    List<dynamic> volEtiquetasID = [];
    for (var etapa in trSincetapas) {
      List<dynamic> volumes = etapa['volumes'] as List<dynamic>;
      for (var volume in volumes) {
        if (volume['volume_data_hora_fim'] == null ||
            volume['volume_data_hora_fim'].toString() == "") {
          List<dynamic> amostras = volume['amostras'] as List<dynamic>;
          for (var amostra in amostras) {
            if (amostra['volam_etiqueta_id'] != null) {
              volEtiquetasID.add(amostra['volam_etiqueta_id']);
            }
          }
        }
      }
    }

    // volumess['foto'].toString() = "1";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Concluído!'),
          content: SingleChildScrollView(
            child: Text(volEtiquetasID.toString()),
          ),
        );
      },
    );
  }

  void semEtiqueta() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ops!'),
          content: SingleChildScrollView(
            child: Text('Parece que não existe essa etiqueta coletada!'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o AlertDialog
              },
            ),
          ],
        );
      },
    );
  }

  void etiquetaRepetita() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ops!'),
          content: SingleChildScrollView(
            child: Text('Parece que ja existe essa etiqueta no volume!'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o AlertDialog
              },
            ),
          ],
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
                    borderColor: Color(0x8FFFFFF),
                    borderRadius: 0,
                    borderLength: 0,
                    borderWidth: 0,
                    overlayColor: Color(0x8FFFFFF),
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
                    onPressed: () async {
                      // FFAppState().teste.add(textController.text);
                      List<dynamic> trSincComS = FFAppState()
                          .trSincroniza
                          .where((element) =>
                              element['fazenda_id'] ==
                                  int.parse(widget.fazId!) &&
                              element['servico_id'] ==
                                  int.parse(widget.oservid!))
                          .map((e) => e["etapas"])
                          .toList()
                          .first;
                      var volumess = trSincComS
                          .map((e) => e["volumes"])
                          //     .where((element) =>
                          // element["volume_data_hora_fim"].isEmpty || element["volume_data_hora_fim"].toString() == null)
                          .toList()
                          // .first
                          .first;
                      var volumesss = volumess
                          .where((element) =>
                              element["volume_data_hora_fim"].isEmpty ||
                              element["volume_data_hora_fim"].toString() ==
                                  null)
                          .toList()
                          .first;
                      // volumess['amostras'].add(textController.text.toString());
                      // volumess['amostras'].add(1);

                      // volumess['amostras'] = ["1","2","3","4"];

                      List<dynamic> trSincEtiqueta = FFAppState()
                          .trSincroniza
                          .where((element) =>
                              element['fazenda_id'] ==
                                  int.parse(widget.fazId!) &&
                              element['servico_id'] ==
                                  int.parse(widget.oservid!))
                          .map((e) => e["pontos"])
                          .toList()
                          .first;
                      List<dynamic> profundidadesNaoSincronizadas = [];

                      for (var ponto in trSincEtiqueta) {
                        var profundidades =
                            ponto['profundidades'] as List<dynamic>;
                        var profundidadesFiltradas = profundidades
                            .where((profundidade) =>
                                profundidade['sincronizado'].toString() == "S")
                            .map((e) => e['pprof_etiqueta_id'])
                            .toList();

                        profundidadesNaoSincronizadas
                            .addAll(profundidadesFiltradas);
                      }

                      //VERIFICAR TAMBEM SE A ETIQUETA JA EXISTE EM AMOSTRAS, SE JA EXISTE, CIRAR UM VOID etiquetaRepetita(), e mostrar qual etiqueta ja foi lida
                      List<dynamic> trSincetapas = FFAppState()
                          .trSincroniza
                          .where((element) =>
                              element['fazenda_id'] ==
                                  int.parse(widget.fazId!) &&
                              element['servico_id'] ==
                                  int.parse(widget.oservid!))
                          .map((e) => e["etapas"])
                          .toList()
                          .first;
                      // List<dynamic> volumesNaoSincronizadas = [];
                      //
                      // for (var volume in trSincetapas) {
                      //   var volumes = volume['volumes'] as List<dynamic>;
                      //   var volumesFiltrados = volumes
                      //       .where((volumes) =>
                      //           volumes['volume_data_hora_fim'].toString() !=
                      //               "" ||
                      //           volumes['volume_data_hora_fim'].toString() !=
                      //               null)
                      //       .map((e) => e['amostras'])
                      //       .toList()
                      //       .first;
                      //
                      //   volumesNaoSincronizadas.addAll(volumesFiltrados);
                      // }

                      List<dynamic> volEtiquetasID = [];
                      for (var etapa in trSincetapas) {
                        List<dynamic> volumes =
                            etapa['volumes'] as List<dynamic>;
                        for (var volume in volumes) {
                          if (volume['volume_data_hora_fim'] == null ||
                              volume['volume_data_hora_fim'].toString() == "") {
                            List<dynamic> amostras =
                                volume['amostras'] as List<dynamic>;
                            for (var amostra in amostras) {
                              if (amostra['volam_etiqueta_id'] != null) {
                                volEtiquetasID
                                    .add(amostra['volam_etiqueta_id']);
                              }
                            }
                          }
                        }
                      }
                      setState(() {
                        //criar select de ppont_icone e ponto (PONTO?)
                        String pesquisa = textController.text
                            .toString(); // Asegúrese de que 'pesquisa' seja do tipo correto e tenha o valor correto
                        if (profundidadesNaoSincronizadas.contains(pesquisa)) {
                          if (volEtiquetasID.toString().contains(pesquisa)) {
                            etiquetaRepetita();
                          } else {
                            List<dynamic> profundidadesNaoSincronizadas3 = [];
                            for (var profIcon in trSincEtiqueta) {
                              var legendaIcone =
                                  profIcon['profundidades'] as List<dynamic>;
                              var legendaIconeFiltrada = legendaIcone
                                  .where((legendaIcone) =>
                                      legendaIcone['sincronizado'].toString() ==
                                          "S" &&
                                      legendaIcone['pprof_etiqueta_id']
                                              .toString() ==
                                          textController.text.toString())
                                  .map((e) => e['pprof_id'])
                                  .toList();

                              profundidadesNaoSincronizadas3
                                  .addAll(legendaIconeFiltrada);
                            }
                            var pprof_id =
                                profundidadesNaoSincronizadas3.first.toString();

                            volumesss['amostras'].add({
                              "volam_etiqueta_id":
                                  textController.text.toString(),
                              "volam_profundidade_id": pprof_id.toString(),
                              "volam_data": DateFormat('yyyy-MM-dd HH:mm')
                                  .format(DateTime.now())
                            });
                            Navigator.of(context).pop();
                            context
                                .pushNamed('criacaoVolume', queryParameters: {
                              'fazId': serializeParam(
                                widget.fazId,
                                ParamType.int,
                              ),
                              'oservId': serializeParam(
                                widget.oservid,
                                ParamType.int,
                              ),
                            });
                          }

                          // volumess['amostras'] = [];
                        } else {
                          semEtiqueta();
                        }
                        // volumess['amostras'].add(textController.text
                        //     .toString()); // Usa um valor padrão (como 0) caso a conversão falhe

                        // atualiza();

                        // Navigator.of(context).pop();
                      });
                      textController.clear();
                      controller?.resumeCamera();
                      // await Future.delayed(Duration(milliseconds: 180));
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
            onPressed: () async {
              // controller?.resumeCamera();
              // textController.clear();
              setState(() {
                //   atualiza();
                //   await Future.delayed(Duration(milliseconds: 380));
                Navigator.of(context).pop();
                context.pushNamed('criacaoVolume', queryParameters: {
                  'fazId': serializeParam(
                    widget.fazId,
                    ParamType.int,
                  ),
                  'oservId': serializeParam(
                    widget.oservid,
                    ParamType.int,
                  ),
                });
                //   Navigator.of(context).pop();
              });
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
