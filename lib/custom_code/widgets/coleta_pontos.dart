// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// import 'package:camera/camera.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';
import 'dart:convert';

// import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart';

import 'package:background_location/background_location.dart'
    as background_location;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:wakelock/wakelock.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart' as xml;

class ColetaPontos extends StatefulWidget {
  const ColetaPontos(
      {super.key,
      this.width,
      this.height,
      this.oservid,
      this.fazId,
      this.fazNome,
      this.fazLatlng,
      this.autoAuditoria,
      this.quantidadeAutoAuditoria,
      this.pontos});

  final double? width;
  final double? height;
  final String? oservid;
  final String? fazId;
  final String? fazNome;
  final LatLng? fazLatlng;
  final String? autoAuditoria;
  final String? quantidadeAutoAuditoria;
  final List<dynamic>? pontos;

  @override
  State<ColetaPontos> createState() => _ColetaPontosState();
}

class _ColetaPontosState extends State<ColetaPontos> {
  google_maps.GoogleMapController? _googleMapController;
  Set<google_maps.Polygon> polygons = Set();
  Set<google_maps.Marker> markers = Set();
  google_maps.LatLng? initialLatLng;
  Position? _currentPosition;
  double _currentZoom = 13.0; // Inicializa o zoom padrão

  StreamSubscription<Position>? _positionStreamSubscription;

  //pontos de medição
  List<Map<String, dynamic>> pontosMedicao = [];

  @override
  void initState() {
    Wakelock.enable();
    super.initState();
    if (widget.fazLatlng != null) {
      initialLatLng = google_maps.LatLng(
          widget.fazLatlng!.latitude, // Usa ! para assegurar que não é nulo
          widget.fazLatlng!.longitude);
    }
    // if(widget.pontos != null){
    //   pontosMedicao = widget.pontos;
    // }

    _criaPontosMarcadors();
    _adicionaPoligonos();
    _getCurrentLocation();
    _trackUserLocation();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    _googleMapController?.dispose();
    super.dispose();
  }

  void _adicionaPoligonos() {
    // Supondo que trTalhoes seja uma lista de talhões, onde cada talhão tem uma lista de coordenadas 'coordenadas'
    var talhoes = FFAppState().trTalhoes;

    for (var talhao in talhoes) {
      var coordenadas = talhao['coordenadas'] as List<dynamic>;
      List<google_maps.LatLng> pontos = [];

      for (var coordenada in coordenadas) {
        var ponto = google_maps.LatLng(
          double.parse(coordenada['talcot_latitude']),
          double.parse(coordenada['talcot_longitude']),
        );
        pontos.add(ponto);
      }

      // Cria um polígono para cada talhão e adiciona ao conjunto de polígonos
      var polygon = google_maps.Polygon(
        polygonId: google_maps.PolygonId('polygon_${talhao['id']}'),
        // Supondo que cada talhão tenha um identificador único 'id'
        points: pontos,
        strokeColor: Colors.yellowAccent,
        // Cor da linha
        fillColor: Colors.yellow.withOpacity(0.34),
        // Cor de preenchimento com transparência
        strokeWidth: 1, // Espessura da linha
      );

      setState(() {
        polygons.add(polygon);
      });
    }
  }

  void _trackUserLocation() {
    _positionStreamSubscription = Geolocator.getPositionStream().listen(
      (Position position) {
        setState(() {
          _currentPosition = position;
          // _updateUserLocationMarker(
          //     position); // Método para atualizar o marcador
          // _updateMapLocation();
        });
      },
    );
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });
  }

  void _onMapCreated(google_maps.GoogleMapController controller) {
    _googleMapController = controller;
  }

  void _onCameraMove(google_maps.CameraPosition position) {
    _currentZoom = position.zoom;
  }

  Uint8List resizeImage(String base64Str, int width, int height) {
    // Decodifica a string base64 para uma imagem
    Uint8List decodedBytes = base64Decode(base64Str);
    // Decodifica a imagem para um objeto de imagem
    img.Image? image = img.decodeImage(decodedBytes);

    // Redimensiona a imagem
    img.Image resized = img.copyResize(image!, width: width, height: height);

    // Codifica a imagem redimensionada de volta para Uint8List
    return Uint8List.fromList(img.encodePng(resized));
  }

  Future<google_maps.BitmapDescriptor> getSvgIcon(String svgString) async {
    final PictureInfo pictureInfo =
        await vg.loadPicture(SvgStringLoader(svgString), null);

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    canvas.drawPicture(pictureInfo.picture);
    final ui.Image image = await pictureRecorder.endRecording().toImage(70, 70);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8list = byteData!.buffer.asUint8List();

    return google_maps.BitmapDescriptor.fromBytes(uint8list);
  }

  void _criaPontosMarcadors() async {
    if (widget.pontos != null) {
      pontosMedicao = List<Map<String, dynamic>>.from(widget.pontos!);
    }
    for (var pontos in widget.pontos!) {
      var latlng = google_maps.LatLng(
        double.parse(pontos['pont_latitude'].toString()),
        double.parse(pontos['pont_longitude'].toString()),
      );
      var markerId = google_maps.MarkerId(pontos["pont_numero"]!.toString());
      // var position =
      // google_maps.LatLng(double.parse(latlng[0]), double.parse(latlng[1]));

      // google_maps.BitmapDescriptor icon = _buscarIcone(pontos['pont_simbolo']);

      final String? svgStr = FFAppState().trIcones.firstWhere(
            (element) => element['ico_valor'] == pontos['pont_simbolo'],
            orElse: () => {'ico_svg': null},
          )['ico_svg'];
      final google_maps.BitmapDescriptor icon = await getSvgIcon(svgStr!);

//       final String? svgStr = '''<svg width="50" height="50" viewBox="0 0 50 50" fill="none" xmlns="http://www.w3.org/2000/svg">
// <path d="M25 50C31.6304 50 37.9893 47.3661 42.6777 42.6777C47.3661 37.9893 50 31.6304 50 25C50 18.3696 47.3661 12.0107 42.6777 7.32233C37.9893 2.63392 31.6304 0 25 0C18.3696 0 12.0107 2.63392 7.32233 7.32233C2.63392 12.0107 0 18.3696 0 25C0 31.6304 2.63392 37.9893 7.32233 42.6777C12.0107 47.3661 18.3696 50 25 50Z" fill="#09335A"/>
// </svg>''';
//
//       final google_maps.BitmapDescriptor icon = await getSvgIcon(svgStr!);

      var marker = google_maps.Marker(
        markerId: markerId,
        position: latlng,
        icon: icon,
        onTap: () {
          // focoNoMarcador = true;
          // latlngMarcador = google_maps.LatLng(
          //     double.parse(latlng[0]), double.parse(latlng[1]));

          // _showDistanceAlert();
          _onMarkerTapped(markerId, pontos["pont_numero"]!.toString(),
              latlng.latitude, latlng.longitude);
        },
        // infoWindow: google_maps.InfoWindow(
        //   title: "PONTO : " + pontos["pont_numero"]!.toString(),
        //   snippet: "Profundidades de coleta: ",
        // ),
        draggable: false,
      );
      setState(() {
        markers.add(marker);
      });
    }
  }

  void _onMarkerTapped(google_maps.MarkerId markerId, String markerName,
      double latitudemarker, double longitudemarker) {
    // print("Marker tapped: $markerName");
    // DateTime now = DateTime.now();
    // String markerIdValue = markerId.value;

    // Retrieve the position of the tapped marker
    google_maps.LatLng markerLatLng =
        google_maps.LatLng(latitudemarker, longitudemarker);
    // latlngMarcador = markerPositions[markerIdValue]!;

    // Calculate the distance between the user's current location and the marker
    double distance = Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      markerLatLng.latitude,
      markerLatLng.longitude,
    );

    // Check if the last tap was within 1.8 seconds to consider it a double tap
    // if (lastTapTimestamps.containsKey(markerIdValue) &&
    //     now.difference(lastTapTimestamps[markerIdValue]!).inMilliseconds <
    //         1800) {
    // Check if the distance is greater than 30 meters
    if (distance > 3500000) {
      //metros de distancia para coletar
      // Show alert
      // _showDistanceAlert();
      _showDistanceAlert();
    } else {
      // Continue with the normal double tap logic
      // _showModalOptions(markerName!.toString());
      _ontapColetar(markerName!.toString());
    }
    // }

    // Update the timestamp of the last tap
    // lastTapTimestamps[markerIdValue] = now;
  }

  void _showDistanceAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aproxime-se do ponto!'),
          content: Text('Você está a mais de 30 metros do ponto de coleta.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _ontapColetar(String marcadorNome) {
    _showProfundidadesParaColeta(marcadorNome);
  }

  // void _showModalOptions(String idMarcador) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         titlePadding: EdgeInsets.all(20),
  //         title: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Expanded(
  //               child: Text(
  //                 "Ponto: $idMarcador",
  //                 style: FlutterFlowTheme.of(context).bodyMedium.override(
  //                       fontFamily: 'Outfit',
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //               ),
  //             ),
  //             InkWell(
  //               onTap: () => Navigator.of(context).pop(),
  //               child: Icon(
  //                 Icons.close,
  //                 color: FlutterFlowTheme.of(context).secondaryText,
  //                 size: 36,
  //               ),
  //             ),
  //           ],
  //         ),
  //         content: Padding(
  //           padding: EdgeInsets.all(20),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               _buildElevatedButton(
  //                   context, "Realizar coleta", Color(0xFF00736D), () {
  //                 Navigator.of(context).pop();
  //                 _ontapColetar(idMarcador);
  //               }),
  //               SizedBox(height: 10),
  //               // _buildElevatedButton(
  //               //     context, "Coleta inacessível", Color(0xFF9D291C), () {
  //               //   Navigator.of(context).pop();
  //               //   // _ontapInacessivel(idMarcador);
  //               // }),
  //               // SizedBox(height: 10),
  //               // _buildElevatedButton(context, "Criar Ponto", Colors.blue, () {
  //               //   Navigator.of(context).pop();
  //               //   // _adicionarNovoPonto();
  //               //   _showAdicionaProfundidades();
  //               //   _showTutorialModal();
  //               // }),
  //               // SizedBox(height: 10),
  //               // _buildElevatedButton(context, "Tirar Foto", Colors.orange, () {
  //               //   Navigator.of(context).pop();
  //               //   _tiraFoto(idMarcador);
  //               // }),
  //             ],
  //           ),
  //         ),
  //         backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
  //         elevation: 5,
  //       );
  //     },
  //   );
  // }

  void _showProfundidadesParaColeta(String marcadorNome) {
    // Encontra o marcador pelo nome
    var marcador = pontosMedicao.firstWhere(
      (m) => m["pont_numero"] == int.parse(marcadorNome),
      orElse: () =>
          <String, Object>{}, // Correção aqui para alinhar com o tipo esperado
    );

    if (marcador.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          var profundidades = marcador["profundidades"] as List<dynamic>? ?? [];

          var latlng =
              "${marcador["pont_latitude"]}, ${marcador['pont_longitude']}";

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            titlePadding: EdgeInsets.all(20),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Ponto: ${marcador["pont_numero"]}",
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.close,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 36,
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: profundidades.map<Widget>((profundidade) {
                  String prof_nome = profundidade['pprof_icone'];
                  var svg = FFAppState()
                      .trIcones
                      .where((element) => element['ico_valor'] == "$prof_nome")
                      .map((e) => e['ico_svg'])
                      .toString();
                  var prof_profundidade = FFAppState()
                      .trIcones
                      .where((element) => element['ico_valor'] == "$prof_nome")
                      .map((e) => e['ico_legenda'])
                      .toString();

                  var referencialProfundidadePontoId = '1';

                  // profundidade["prof_id"].toString();
                  // bool jaColetada = coletasPorMarcador[marcadorNome]
                  //         ?.contains(profundidade["nome"]) ??
                  //     false;

                  bool jaColetada = false;
                  // FFAppState().PontosColetados.any((pontoColetado) {
                  //   return pontoColetado['marcador_nome'].toString() ==
                  //       marcadorNome.toString() &&
                  //       pontoColetado['profundidade'].toString() ==
                  //           profundidade["nome"];
                  // });

                  // Verificação adicional para 'pontosJaColetados'
                  // if (!jaColetada /*&& widget.pontosJaColetados*/ != null) {
                  //   jaColetada = widget.pontosJaColetados!.any((pontoString) {
                  //     try {
                  //       var pontoMap =
                  //       json.decode(pontoString) as Map<dynamic, dynamic>;
                  //       return pontoMap["marcador_nome"].toString() ==
                  //           marcadorNome;
                  //       // &&
                  //       // pontoMap["profundidade"].toString() ==
                  //       //     profundidade["nome"].toString();
                  //     } catch (e) {
                  //       print("Erro ao decodificar ponto: $e");
                  //       return false;
                  //     }
                  //   }
                  //   );
                  // }

                  return Row(
                    children: [
                      SvgPicture.string(
                        svg,
                        width: 20,
                        height: 20,
                        // Adiciona um BoxFit para garantir que o SVG seja exibido corretamente
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 10),
                      Text(prof_profundidade
                          .toString()
                          .replaceAll("(", "")
                          .replaceAll(")", "")),
                      Spacer(),
                      _buildElevatedButton(
                        context,
                        jaColetada ? "Coletada" : "Coletar",
                        jaColetada ? Color(0xFF9D291C) : Color(0xFF00736D),
                        () {
                          if (jaColetada) {
                            // _confirmarRecoleta(
                            //     context,
                            //     marcadorNome,
                            //     profundidade["nome"],
                            //     latlng,
                            //     referencialProfundidadePontoId);
                          } else {
                            _confirmarColeta(
                                context,
                                marcadorNome,
                                profundidade["pprof_id"],
                                latlng,
                                referencialProfundidadePontoId);
                          }
                        },
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            actions: <Widget>[
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor:
                        Color(0xFFEDA300), // Cor laranja para o botão
                    primary: Colors.white, // Cor do texto
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Borda arredondada para o botão
                    ),
                  ),
                  child: Text('Ponto Inacessível'),
                  onPressed: () {
                    // Adicione aqui a ação desejada para quando o botão for pressionado
                    Navigator.of(context).pop();
                    _ontapInacessivel(marcadorNome, latlng);
                  },
                ),
              ),
            ],
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 5,
          );
        },
      );
    }
  }

  void _ontapInacessivel(String marcadorNome, String latlngMarcador) {
    // var profunidade = pontosMedicao.map((e) => e[])
    _tiraFoto(marcadorNome, latlngMarcador);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        // Ajusta o padding superior baseado na altura do teclado, se o teclado estiver visível
        var topPadding = keyboardHeight > 0 ? 120 : 450;

        return Dialog(
          insetPadding: EdgeInsets.fromLTRB(
              0, topPadding.toDouble(), 0, 0), // Usa o topPadding dinâmico
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.all(20),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Porque o ponto: $marcadorNome esta inacessível?",
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.close,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 36,
                  ),
                ),
              ],
            ),
            content: Padding(
              // padding: EdgeInsets.all(20),
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Informe porque o ponto está inacessível:',
                      labelStyle: FlutterFlowTheme.of(context).bodyMedium,
                      hintStyle: FlutterFlowTheme.of(context).labelMedium,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Text(
                    "Foto Capturada!",
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // Centraliza os botões na Row
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          // Implemente a lógica para capturar foto
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF087071), // Cor do botão
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                100), // Bordas arredondadas
                          ),
                        ),
                        child: Text("Capturar foto",
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 30), // Espaçamento entre os botões
                      ElevatedButton(
                        onPressed: () {
                          // Implemente a ação para este botão
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF087071), // Cor do botão
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                100), // Bordas arredondadas
                          ),
                        ),
                        child: Icon(Icons.arrow_forward,
                            color: Colors.white), // Ícone dentro do botão
                      ),
                    ],
                  ),
                ],
              ),
            ),
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 5,
          ),
        );
      },
    );
  }

  void _tiraFoto(String nomeMarcadorAtual, String latlng) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      // final bytes = await image.readAsBytes();
      Uint8List bytes = await image.readAsBytes();

      // Utiliza a biblioteca 'image' para decodificar a imagem
      img.Image? originalImage = img.decodeImage(bytes);

      if (originalImage != null) {
        // Redimensiona a imagem para 33% da sua qualidade original
        img.Image resizedImage = img.copyResize(originalImage,
            width: (originalImage.width * 0.23).round(),
            height: (originalImage.height * 0.23).round());

        // Converte a imagem redimensionada de volta para bytes como PNG
        List<int> resizedBytes = img.encodePng(resizedImage);

        // Converte os bytes da imagem redimensionada para uma string base64
        String base64Image = base64Encode(Uint8List.fromList(resizedBytes));

        setState(() {
          // Encontra o marcador pelo nome
          // int indexMarcador = pontosMedicao.indexWhere(
          //         (marcador) => marcador['pont_numero'] == nomeMarcadorAtual);

          // if (indexMarcador != -1) {
          //   pontosMedicao[indexMarcador]['foto_de_cada_profundidade']
          //       .add({
          //     'nome': nomeProfundidade,
          //     'foto': 'data:image/png;base64,base64Image',
          //     // 'foto': 'data:image/png;base64,$base64Image',
          //   });

          FFAppState().PontosColetados.add({
            "marcador_nome": nomeMarcadorAtual,
            "profundidade": 'inacessivel',
            "foto": 'base64Image',
            // "foto": '$base64Image',
            "latlng": '$latlng',
            "id_ref": '1',
            "obs": "",
            "data_hora": DateTime.now().toString()
          });

          // coletasPorMarcador.putIfAbsent(nomeMarcadorAtual, () => {});
          // coletasPorMarcador[nomeMarcadorAtual]!.add(nomeProfundidade);

          // Verifica se todas as profundidades foram coletadas
          var todasProfundidades = pontosMedicao
              .firstWhere(
                  (m) => m["pont_numero"] == nomeMarcadorAtual)["profundidades"]
              .map((p) => p["pprof_id"])
              .toSet();

          // if (coletasPorMarcador[nomeMarcadorAtual]!
          //     .containsAll(todasProfundidades)) {
          //   // Todas as profundidades coletadas, mude a cor do marcador para verde
          //   _updateMarkerColor(nomeMarcadorAtual, true);
          //   setState(() {
          //     vezAtualDoIntervaloDeColeta += 1;
          //   });
          // };

          // Navigator.of(context).pop(); // Fecha o modal atual
          // _mostrarModalSucesso(context, nomeMarcadorAtual);
        });
      }
    }
    Navigator.of(context).pop(); // Fecha o modal atual
    // _showModalObservacoes(
    //     nomeMarcadorAtual, referencialProfundidadePontoId, nomeProfundidade);
    // Navigator.of(context).pop(); // Fecha o modal atual
  }

  void _confirmarColeta(
      BuildContext context,
      String marcadorNome,
      String profundidadeNome,
      String latlng,
      String referencialProfundidadePontoId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Efetuar coleta'),
          content: Text('Deseja realmente efetuar esta coleta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Não'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // if (podeTirarFoto) {
                //   if (vezAtualDoIntervaloDeColeta >=
                //       intervaloDeColetaParaProximaFoto ||
                //       vezAtualDoIntervaloDeColeta == 0) {
                //     _tiraFoto(marcadorNome, profundidadeNome, latlng,
                //         referencialProfundidadePontoId);
                //     setState(() {
                //       vezAtualDoIntervaloDeColeta = 0;
                //     });
                //     // _coletarProfundidade(marcadorNome, profundidadeNome, latlng,
                //     //     referencialProfundidadePontoId);
                //   } else {
                _coletarProfundidade(marcadorNome, profundidadeNome, latlng,
                    referencialProfundidadePontoId);
                // }
                // } else {
                //   _coletarProfundidade(marcadorNome, profundidadeNome, latlng,
                //       referencialProfundidadePontoId);
                // }
              },
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  void _coletarProfundidade(String marcadorNome, String profundidadeNome,
      String latlng, String referencialProfundidadePontoId) {
    setState(() {
      // pontosColetados.add({
      //   "marcador_nome": marcadorNome,
      //   "profundidade": profundidadeNome,
      //   "foto": '',
      //   "latlng": latlng,
      //   "id_ref": '$referencialProfundidadePontoId',
      //   "obs": "",
      //   "data_hora": DateTime.now().toString()
      // });
      // FFAppState().PontosColetados.add({
      //   "marcador_nome": marcadorNome,
      //   "profundidade": profundidadeNome,
      //   // "foto": '$base64Image',
      //   "foto": '',
      //   "latlng": latlng,
      //   "id_ref": '$referencialProfundidadePontoId',
      //   "obs": "",
      //   "data_hora": DateTime.now().toString()
      // });

      // coletasPorMarcador.putIfAbsent(marcadorNome, () => {});
      // coletasPorMarcador[marcadorNome]!.add(profundidadeNome);

      // // Verifica se todas as profundidades foram coletadas
      // var todasProfundidades = latLngListMarcadores
      //     .firstWhere(
      //         (m) => m["marcador_nome"] == marcadorNome)["profundidades"]
      //     .map((p) => p["nome"])
      //     .toSet();

      //   if (coletasPorMarcador[marcadorNome]!.containsAll(todasProfundidades)) {
      //     // Todas as profundidades coletadas, mude a cor do marcador para verde
      //     _updateMarkerColor(marcadorNome, true);
      //     setState(() {
      //       vezAtualDoIntervaloDeColeta += 1;
      //     });
      //   }
    });
    Navigator.of(context).pop(); // Fecha o modal atual
    _mostrarModalSucesso(context, marcadorNome);
  }

  void _mostrarModalSucesso(BuildContext context, String marcadorNome) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 0, milliseconds: 940), () {
          Navigator.of(context).pop(); // Fecha o modal de sucesso
          _showProfundidadesParaColeta(
              marcadorNome); // Reabre o modal de coletas
        });

        return AlertDialog(
          title: Text('Sucesso'),
          content: Text('Profundidade coletada!'),
        );
      },
    );
  }

  Widget _buildElevatedButton(
      BuildContext context, String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      child: Text(
        text,
        style: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'Readex Pro',
              color: Colors.white,
            ),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 3,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      ),
    );
  }

  void _onMapTap(google_maps.LatLng position) {
    // Implemente a lógica para o que deve acontecer quando o mapa é tocado
  }

  @override
  Widget build(BuildContext context) {
    google_maps.LatLng initialTarget =
        initialLatLng ?? google_maps.LatLng(0.0, 0.0);

    return WillPopScope(
      onWillPop: () async {
        // Sua lógica para mostrar o diálogo de confirmação permanece igual
        return true; // Retornar true ou false conforme a escolha do usuário
      },
      child: Scaffold(
        body: google_maps.GoogleMap(
          initialCameraPosition: google_maps.CameraPosition(
            target: initialTarget,
            zoom: _currentZoom,
          ),
          onMapCreated: _onMapCreated,
          onTap: _onMapTap,
          onCameraMove: _onCameraMove,
          polygons: polygons,
          markers: markers,
          myLocationEnabled: true,
          mapType: google_maps.MapType.satellite,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _exibirDados(),
          child: Icon(Icons.info),
        ),
      ),
    );
  }

  void _exibirDados() {
    // var listaTalh = FFAppState().trTalhoes.expend((e) => e[''coordenadas]).toList();
    var pontos = widget.pontos!.map((e) => e['pont_id']);
    var marcador = pontosMedicao.firstWhere(
      (m) => m["pont_numero"] == 381,
      orElse: () =>
          <String, Object>{}, // Correção aqui para alinhar com o tipo esperado
    );
    var fotos = FFAppState().PontosColetados.map((e) => e['marcador_nome']);

    // List<google_maps.LatLng> teste = [];

    // Dart usa 'for' para iterar sobre listas, ao invés de 'foreach'
    // for (var item in listaTalh) {
    //   // Supondo que cada 'item' é um mapa com as chaves 'talcot_latitude' e 'talcot_longitude'
    //   var cord = google_maps.LatLng(
    //     double.parse(item['talcot_latitude']),
    //     double.parse(item['talcot_longitude']),
    //   );
    //   teste.add(cord);
    // }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Dados da Coleta'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  "Pontos:${fotos}",
                  style: TextStyle(color: Colors.black, fontSize: 12.0),
                ),
                // Adicione mais widgets Text ou outros conforme necessário
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
