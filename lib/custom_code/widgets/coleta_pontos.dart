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

import 'index.dart'; // Imports other custom widgets
import 'package:flutter_image_compress/flutter_image_compress.dart';

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
import 'package:intl/intl.dart';

import 'package:background_location/background_location.dart'
    as background_location;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:wakelock/wakelock.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart' as xml;

import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:qr_scanner_overlay_shape/qr_scanner_overlay_shape.dart';

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
      this.pontos,
      this.podeColetarOuNaoPodeColetar2});

  final double? width;
  final double? height;
  final String? oservid;
  final String? fazId;
  final String? fazNome;
  final LatLng? fazLatlng;
  final bool? autoAuditoria;
  final String? quantidadeAutoAuditoria;
  final List<dynamic>? pontos;
  final bool? podeColetarOuNaoPodeColetar2;

  @override
  State<ColetaPontos> createState() => _ColetaPontosState();
}

class _ColetaPontosState extends State<ColetaPontos> {
  final FocusNode _observacaoFocusNode = FocusNode();
  final FocusNode observaFotoFocusNode = FocusNode();

  bool podeColetarOuNaoPodeColetar = false;

  Map<String, dynamic> jsonSincronizaPosterior = {};

  bool _isLastCollect = false;
  UniqueKey _key = UniqueKey();
  Key _checkboxKey = UniqueKey();

  var qrText = "";
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool Done_Button = false;
  TextEditingController _codigoQr = TextEditingController();

  int quantidadeDeProfundidadesASeremColetadas = 0;

  // int totalProfundidades = 0;

  bool? autoAuditoriaPontos; // = true;
  int quantidadeDeVezesParaAutoAuditarComFoto = 0; // = 1;
  int vezAtualDeFoto = 0;

  google_maps.GoogleMapController? _googleMapController;
  Set<google_maps.Polygon> polygons = Set();
  Set<google_maps.Marker> markers = Set();
  google_maps.LatLng? initialLatLng;
  Position? _currentPosition;
  double _currentZoom = 13.0; // Inicializa o zoom padrão
  String? baseString; //base64foto inpossivel coleta no local
  TextEditingController _observacaoController =
      TextEditingController(); //texto obs inacessivel
  TextEditingController observaFotoController =
      TextEditingController(); //texto obs inacessivel

  bool? isPrimeiraColeta =
      true; //essa variavel guarda a primeira coleta do dia, se ela ja foi feita ou não

  StreamSubscription<Position>? _positionStreamSubscription;

  //pontos de medição
  List<Map<String, dynamic>> pontosMedicao = [];

  void updateTrSincro() {
    var trSincroList = FFAppState()
        .trSincroniza
        .where((element) =>
            element['fazenda_id'] == int.parse(widget.fazId!) &&
            element['servico_id'] == int.parse(widget.oservid!))
        .toList();

    // Verifica se a lista não está vazia antes de proceder
    if (trSincroList.isNotEmpty) {
      var trSincro = trSincroList.first;
      // Adiciona 'etiquetas' se não existir
      trSincro['etiquetas'] ??= [];
    }
  }

  @override
  void initState() {
    Wakelock.enable();
    super.initState();

    updateTrSincro();

    podeColetarOuNaoPodeColetar = widget.podeColetarOuNaoPodeColetar2 ?? false;

    String fazendaId = widget.fazId ??
        ""; // Usando ?? para fornecer um valor padrão se for nulo
    String servicoId = widget.oservid ?? "";
//verifica se a coleta ja não foi inicada

    var coletasIniciadas = FFAppState().listaColetasInciadas.where((element) =>
        element['oserv_id'] == widget.oservid &&
        element['faz_id'] == widget.fazId);
    if (coletasIniciadas.isNotEmpty) {
      isPrimeiraColeta = false;
    }

    // Para converter uma String para boolean
    // if (widget.autoAuditoria != null) {
    autoAuditoriaPontos = widget.autoAuditoria;
    // }

// // Para converter uma String para int
    if (widget.quantidadeAutoAuditoria != null) {
      quantidadeDeVezesParaAutoAuditarComFoto =
          int.tryParse(widget.quantidadeAutoAuditoria!)!;
    }
    Map<String, dynamic> jsonSincronizaPosterior = {
      "fazenda_id": fazendaId,
      "servico_id": servicoId,
      "pontos": [
        {
          "id": 381,
          "status": 1,
          "obs": "quando ponto inacessível precisa de obs",
          "foto": "quando ponto inacessível precisa de foto",
          "profundidades": [
            {
              "id": 1,
              "status": 1,
              "obs": "opcional",
              "foto": "conforme auditoria",
              "data": "2024-02-24 08:00"
            },
          ]
        },
        {
          "id": 382,
          "status": 1,
          "obs": "",
          "foto": "base64",
          "profundidades": [
            {
              "id": 1,
              "status": 1,
              "obs": "",
              "foto": "",
              "data": "2024-02-24 08:00"
            },
          ]
        },
      ]
    };

    if (widget.fazLatlng != null) {
      initialLatLng = google_maps.LatLng(
          widget.fazLatlng!.latitude, // Usa ! para assegurar que não é nulo
          widget.fazLatlng!.longitude);
    }

    var totalProfundidades = 0;
// Usando ?.map() para evitar erro se widget.pontos for nulo,
// e fornecendo uma lista vazia como valor padrão com ?? [].
    var pontosASeremColetados = widget.pontos
            ?.map((e) => e['profundidades'] as List<dynamic>)
            .toList() ??
        [];

    for (var profundidadesDeCadaPonto in pontosASeremColetados) {
      // Removido o operador ! de profundidadesDeCadaPonto.length, pois length retorna um int e não pode ser nulo.
      totalProfundidades += profundidadesDeCadaPonto.length;
    }

    quantidadeDeProfundidadesASeremColetadas = totalProfundidades;

    _criaPontosMarcadors();
    _adicionaPoligonos();
    _getCurrentLocation();
    _trackUserLocation();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    _googleMapController?.dispose();
    _observacaoController.dispose();
    _codigoQr.dispose();
    observaFotoController.dispose();
    super.dispose();
  }

  void _adicionaPoligonos() {
    // Supondo que trTalhoes seja uma lista de talhões, onde cada talhão tem uma lista de coordenadas 'coordenadas'
    var talhoes = FFAppState().trTalhoesEmCadaServico.firstWhere((registro) =>
        registro['fazenda_id'].toString() == widget.fazId! &&
        registro['servico_id'].toString() == widget.oservid!)['dados'];
    // var talhoes = FFAppState().trTalhoes;

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
      var idPonto = pontos['point_id'].toString();
      var markerId = google_maps.MarkerId(pontos["pont_numero"]!.toString());

      var coletouTodas = _validaSeTodasAsProfundidadesForamColetadasNoPontoX(
          pontos["pont_numero"]!.toString());

      // Define o ícone padrão baseado no SVG se o ponto não estiver na lista de inacessíveis
      String svgColet =
          '''<svg width="70" height="70" viewBox="0 0 70 70" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M35 70C44.2826 70 53.185 66.3125 59.7487 59.7487C66.3125 53.185 70 44.2826 70 35C70 25.7174 66.3125 16.815 59.7487 10.2513C53.185 3.68749 44.2826 0 35 0C25.7174 0 16.815 3.68749 10.2513 10.2513C3.68749 16.815 0 25.7174 0 35C0 44.2826 3.68749 53.185 10.2513 59.7487C16.815 66.3125 25.7174 70 35 70ZM50.4492 28.5742L32.9492 46.0742C31.6641 47.3594 29.5859 47.3594 28.3145 46.0742L19.5645 37.3242C18.2793 36.0391 18.2793 33.9609 19.5645 32.6895C20.8496 31.418 22.9277 31.4043 24.1992 32.6895L30.625 39.1152L45.8008 23.9258C47.0859 22.6406 49.1641 22.6406 50.4355 23.9258C51.707 25.2109 51.7207 27.2891 50.4355 28.5605L50.4492 28.5742Z" fill="#0C5905"/>
</svg>''';

      String svgError =
          '''<svg width="70" height="70" viewBox="0 0 70 70" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M35 70C44.2826 70 53.185 66.3125 59.7487 59.7487C66.3125 53.185 70 44.2826 70 35C70 25.7174 66.3125 16.815 59.7487 10.2513C53.185 3.68749 44.2826 0 35 0C25.7174 0 16.815 3.68749 10.2513 10.2513C3.68749 16.815 0 25.7174 0 35C0 44.2826 3.68749 53.185 10.2513 59.7487C16.815 66.3125 25.7174 70 35 70ZM23.9258 23.9258C25.2109 22.6406 27.2891 22.6406 28.5605 23.9258L34.9863 30.3516L41.4121 23.9258C42.6973 22.6406 44.7754 22.6406 46.0469 23.9258C47.3184 25.2109 47.332 27.2891 46.0469 28.5605L39.6211 34.9863L46.0469 41.4121C47.332 42.6973 47.332 44.7754 46.0469 46.0469C44.7617 47.3184 42.6836 47.332 41.4121 46.0469L34.9863 39.6211L28.5605 46.0469C27.2754 47.332 25.1973 47.332 23.9258 46.0469C22.6543 44.7617 22.6406 42.6836 23.9258 41.4121L30.3516 34.9863L23.9258 28.5605C22.6406 27.2754 22.6406 25.1973 23.9258 23.9258Z" fill="#AA0303"/>
</svg>''';

      String? svgStr = FFAppState().trIcones.firstWhere(
            (element) => element['ico_valor'] == pontos['pont_simbolo'],
            orElse: () => {'ico_svg': null},
          )['ico_svg'];
      google_maps.BitmapDescriptor icon;
      // Verifica se o ponto atual está na lista de pontos inacessíveis

      List<dynamic> lista = FFAppState()
          .trSincroniza
          .where((element) =>
              element['fazenda_id'] == int.parse(widget.fazId!) &&
              element['servico_id'] == int.parse(widget.oservid!))
          .map((e) => e["pontos"])
          .toList()
          .first;
      var listaSemiFiltrada = lista
          .where((element) =>
              element["pont_numero"] ==
              pontos["pont_numero"]! /*Aqui pe o pont_id, id_ponto*/)
          .first;
      bool isPontoInacessivel = listaSemiFiltrada["profundidades"]
          .every((element) => element["pprof_status"] == 2);

      if (isPontoInacessivel) {
        // Se o ponto estiver inacessível, usa um ícone específico para isso
        icon = await getSvgIcon(svgError!);
      } else {
        if (coletouTodas) {
          icon = await getSvgIcon(svgColet!);
        } else {
          icon = await getSvgIcon(svgStr!);
        }
      }

      //infowindow de coleta inacessivel
      google_maps.InfoWindow infoWindow;
      if (isPontoInacessivel) {
        // Configura a InfoWindow para pontos inacessíveis
        infoWindow = google_maps.InfoWindow(
          title: "Ponto Inacessível: " + pontos["pont_numero"]!.toString(),
          snippet: "Este ponto não pode ser acessado.",
        );
      } else {
        // Configura a InfoWindow para pontos normais
        infoWindow = google_maps.InfoWindow();
      }

      var marker = google_maps.Marker(
        markerId: markerId,
        position: latlng,
        icon: icon,
        onTap: () {
          // focoNoMarcador = true;
          // latlngMarcador = google_maps.LatLng(
          //     double.parse(latlng[0]), double.parse(latlng[1]));

          // _showDistanceAlert();
          if (isPontoInacessivel == false) {
            _onMarkerTapped(markerId, pontos["pont_numero"]!.toString(),
                latlng.latitude, latlng.longitude);
          }
        },
        infoWindow: infoWindow,
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
    if (distance > 35000000) {
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

  void _showAlertaImagem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ops!'),
          content: Text(
              'Para marcar um ponto como inacessível, você precisa capturar uma foto e adicionar uma observação.'),
          actions: <Widget>[
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
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

  void _finalizouColeta() async {
//     var lista = FFAppState().PontosColetados.where((element) =>
//         element['oserv_id'] == widget.oservid &&
//         element['faz_id'] == widget.fazId);
//     String formatDateTime(String dateTimeStr) {
//       DateTime dateTime = DateTime.parse(dateTimeStr);
//       DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
//       return formatter.format(dateTime);
//     }
//
//     Map<int, List<Map<String, dynamic>>> groupedByPontoId = {};
//
//     for (var item in lista) {
//       int idPonto = int.parse(item["id_ponto"]);
//       int marcador_nome = int.parse(item["marcador_nome"]);
//
//       if (!groupedByPontoId.containsKey(idPonto)) {
//         groupedByPontoId[idPonto] = [];
//       }
//       groupedByPontoId[idPonto]!.add(item);
//     }
//
//     List<Map<String, dynamic>> transformedList = [];
//
//     groupedByPontoId.forEach((idPonto, items) {
//       var profundidades = items
//           .map((item) => {
//                 "pprof_id": int.parse(item["profundidade"]),
//                 "pprof_status": 1,
//                 "pprof_icone": item['profundidade'],
//                 "pprof_observacao": item["obs"].toString() ?? "Sem observação!",
//                 "pprof_foto": item["foto"].toString() ?? "",
//                 "pprof_datahora": formatDateTime(item["data_hora"].toString()),
//               })
//           .toList();
//
//       transformedList.add({
//         "pont_id": idPonto,
//         "pont_numero": items.first["marcador_nome"],
//         "pont_latitude": "",
//         "pont_longitude": "",
//         "pont_simbolo": "Pin, Green",
//         "pont_status": 1,
//         "pont_observacao": "",
//         "pont_foto": "",
//         "profundidades": profundidades,
//       });
//     });
//
//     var listaIna = FFAppState().PontosInacessiveis.where((element) =>
//         element['oserv_id'] == widget.oservid &&
//         element['faz_id'] == widget.fazId);
//
//     Map<int, List<Map<String, dynamic>>> groupedByPontoIdInacessivel = {};
//
//     for (var item in listaIna) {
//       int idPonto = int.parse(item["id_ponto"]);
//
//       if (!groupedByPontoIdInacessivel.containsKey(idPonto)) {
//         groupedByPontoIdInacessivel[idPonto] = [];
//       }
//       groupedByPontoIdInacessivel[idPonto]!.add(item);
//     }
//
//     List<Map<String, dynamic>> transformedListInacessiveis = [];
//
//     groupedByPontoIdInacessivel.forEach((idPonto, items) {
//       for (var item in items) {
//         var profundidades = items
//             .map((item) => {
//                   "pprof_id": item["profundidade"],
//                   "pprof_status": 2,
//                   "pprof_icone": item['profundidade'],
//                   "pprof_observacao": "",
//                   "pprof_foto": "",
//                   "pprof_datahora":
//                       formatDateTime(item["data_hora"].toString()),
//                 })
//             .toList();
//
//         transformedListInacessiveis.add({
//           "pont_id": idPonto,
//           "pont_numero": items.first["marcador_nome"],
//           "pont_latitude": "",
//           "pont_longitude": "",
//           "pont_simbolo": "",
//           "pont_status": 2,
//           "pont_observacao": items.first["obs"].toString(),
//           "pont_foto": items.first["foto"].toString(),
//           "profundidades": profundidades,
//         });
//       }
//     });
//     var jaExisteTrSincroniza = FFAppState()
//         .trSincroniza
//         .where((element) =>
//             element['fazenda_id'] == widget.fazId.toString() &&
//             element['servico_id'] == widget.oservid.toString())
//         .toList();
//
// // Checa se algum elemento foi encontrado
//     if (jaExisteTrSincroniza.isNotEmpty) {
//       // Atualiza o primeiro elemento encontrado
//       // Esta é uma abordagem simplificada; ajuste conforme a necessidade de sua aplicação
//       int index = FFAppState().trSincroniza.indexOf(jaExisteTrSincroniza.first);
//       if (index != -1) {
//         // Verifica se encontrou o índice corretamente
//         var listaCompleta = transformedList + transformedListInacessiveis;
//
//         FFAppState().trSincroniza[index] = await atualizaListas(
//             FFAppState().trSincroniza[index], listaCompleta);
//       }
//     } else {
//       // Adiciona um novo elemento, pois não foi encontrado nenhum correspondente
//       FFAppState().trSincroniza.add({
//         "fazenda_id": widget.fazId.toString(),
//         "servico_id": widget.oservid.toString(),
//         "pontos": transformedList + transformedListInacessiveis,
//       });
//     }
  }

  String formatDateTime(String dateTimeStr) {
    // Cria um objeto DateTime a partir da string
    DateTime dateTime = DateTime.parse(dateTimeStr);
    // Cria um formatador com o padrão desejado
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    // Retorna a string formatada
    return formatter.format(dateTime);
  }

  void _ontapColetar(String marcadorNome) {
    _showProfundidadesParaColeta(marcadorNome);
  }

  void _showProfundidadesParaColeta(String marcadorNome) async {
    // Encontra o marcador pelo nome
    var marcador = pontosMedicao.firstWhere(
      (m) => m["pont_numero"] == int.parse(marcadorNome),
      orElse: () =>
          <String, Object>{}, // Correção aqui para alinhar com o tipo esperado
    );
    print(_validaSeTodasAsProfundidadesForamColetadasNoPontoX(marcadorNome));
    print(_validaSeAlgumasProfundidadesForamColetadasNoPontoX(marcadorNome));
    var idPonto = marcador['pont_id'].toString();
    var profundiade = marcador['profundiade'].toString();
    ;
    var coletouAlguma =
        _validaSeAlgumasProfundidadesForamColetadasNoPontoX(marcadorNome);
    var coletouTodas =
        _validaSeTodasAsProfundidadesForamColetadasNoPontoX(marcadorNome);

    if (coletouTodas) {
      String svgError =
          '''<svg width="70" height="70" viewBox="0 0 70 70" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M35 70C44.2826 70 53.185 66.3125 59.7487 59.7487C66.3125 53.185 70 44.2826 70 35C70 25.7174 66.3125 16.815 59.7487 10.2513C53.185 3.68749 44.2826 0 35 0C25.7174 0 16.815 3.68749 10.2513 10.2513C3.68749 16.815 0 25.7174 0 35C0 44.2826 3.68749 53.185 10.2513 59.7487C16.815 66.3125 25.7174 70 35 70ZM50.4492 28.5742L32.9492 46.0742C31.6641 47.3594 29.5859 47.3594 28.3145 46.0742L19.5645 37.3242C18.2793 36.0391 18.2793 33.9609 19.5645 32.6895C20.8496 31.418 22.9277 31.4043 24.1992 32.6895L30.625 39.1152L45.8008 23.9258C47.0859 22.6406 49.1641 22.6406 50.4355 23.9258C51.707 25.2109 51.7207 27.2891 50.4355 28.5605L50.4492 28.5742Z" fill="#0C5905"/>
</svg>''';

      var newIcon = await getSvgIcon(svgError!);

      setState(() {
        _isLastCollect = false;
        markers = markers.map((m) {
          if (m.markerId.value == marcadorNome) {
            return m.copyWith(iconParam: newIcon);
          }
          return m;
        }).toSet();
        isPrimeiraColeta = false;
        if (vezAtualDeFoto <= 0) {
          vezAtualDeFoto = int.parse(widget.quantidadeAutoAuditoria!);
        } else {
          vezAtualDeFoto--;
        }
        ;
        FFAppState().PontosTotalmenteColetados.add({
          "oserv_id": widget.oservid,
          "faz_id": widget.fazId,
          "ponto": idPonto.toString(),
        });

        int registros = FFAppState()
                .PontosColetados
                .where((element) =>
                    element['oserv_id'] == widget.oservid &&
                    element['faz_id'] == widget.fazId)
                .length +
            FFAppState()
                .PontosInacessiveis
                .where((element) =>
                    element['oserv_id'] == widget.oservid &&
                    element['faz_id'] == widget.fazId)
                .length;
        var aColetar = pontosMedicao
            .expand((e) => e['profundidades'] as List<dynamic>)
            .map((profundidade) => profundidade['pprof_id'])
            .toList();
        if (registros == aColetar.length) {
          _finalizouColeta();
        }
      });
    }

    if (marcador.isNotEmpty) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          var profundidades = marcador["profundidades"] as List<dynamic>? ?? [];

          var latlng =
              "${marcador["pont_latitude"]}, ${marcador['pont_longitude']}";

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            insetPadding: EdgeInsets.zero,

            titlePadding: EdgeInsets.all(15),
            title: Container(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Ponto: ${marcador["pont_numero"]}",
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Outfit',
                            fontSize: 17,
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
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: profundidades.map<Widget>((profundidade) {
                  String prof_nome = profundidade['pprof_icone'];
                  var prof_id = profundidade['pprof_id'];
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

                  List<dynamic> lista = FFAppState()
                      .trSincroniza
                      .where((element) =>
                          element['fazenda_id'] == int.parse(widget.fazId!) &&
                          element['servico_id'] == int.parse(widget.oservid!))
                      .map((e) => e["pontos"])
                      .toList()
                      .first;

                  var listaFiltrada = lista
                      .where((element) =>
                          element["pont_id"] ==
                          int.parse(idPonto) /*Aqui pe o pont_id, id_ponto*/)
                      .map((e) => e['profundidades'])
                      .first
                      .where((element) => element["pprof_id"] == prof_id)
                      .toList()
                      .first; /* == 20321*/ /*aqui é o pprof_id ou profundiadde*/ /*);*/
                  // var listaSemiFiltrada/*lista antes das profundiades*/ = lista.where((element) => element["pont_id"] == int.parse(idPonto)/*Aqui pe o pont_id, id_ponto*/).first;/*.map((e) => e['profundidades']).first.where((element) => element["pprof_id"] == 20321).toList().first;*//* == 20321*//**//*aqui é o pprof_id ou profundiadde*//**//*);*/

                  bool jaColetada;
                  if (listaFiltrada["pprof_status"].toString() != '0') {
                    jaColetada = true;
                  } else {
                    jaColetada = false;
                  }

                  // bool jaColetada = //false;
                  //     FFAppState().PontosColetados.any((pontoColetado) {
                  //   return pontoColetado['marcador_nome'].toString() ==
                  //           marcadorNome.toString() &&
                  //       pontoColetado['profundidade'].toString() ==
                  //           profundidade['pprof_id'].toString();
                  // });

                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.,
                    children: [
                      SvgPicture.string(
                        svg,
                        width: 20,
                        height: 20,
                        // Adiciona um BoxFit para garantir que o SVG seja exibido corretamente
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 10),
                      Text(
                        prof_profundidade
                            .toString()
                            .replaceAll("(", "")
                            .replaceAll(")", ""),
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Outfit',
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
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
                            if (podeColetarOuNaoPodeColetar != false) {
                              _confirmarColeta(
                                  context,
                                  marcadorNome,
                                  profundidade["pprof_id"].toString(),
                                  latlng,
                                  referencialProfundidadePontoId,
                                  idPonto);
                            } else {
                              _naoPodeColetarSemIniciarEtapa();
                            }
                          }
                        },
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            actions: <Widget>[
              if (!coletouAlguma)
                Center(
                  key: _key,
                  child: IntrinsicWidth(
                    child: ListTile(
                      title: Text('É a última coleta da etapa?',
                          style: TextStyle(color: Colors.black)),
                      leading: Checkbox(
                        key: _checkboxKey,
                        value: _isLastCollect,
                        onChanged: (bool? value) {
                          setState(() {
                            _isLastCollect = value ?? false;
                            Navigator.of(context).pop();
                            _showProfundidadesParaColeta(
                                marcadorNome); // Renova a chave para forçar a atualização do widget
                          });
                          print(_isLastCollect);
                        },
                        activeColor:
                            Color(0xFF087071), // Cor quando selecionado
                      ),
                      tileColor: Colors.transparent, // Cor de fundo do ListTile
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            100), // Borda arredondada para o ListTile
                      ),
                    ),
                  ),
                ),
              if (!coletouAlguma)
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          Color(0xFFEDA300), // Cor laranja para o botão
                      primary: Colors.white, // Cor do texto
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            100), // Borda arredondada para o botão
                      ),
                    ),
                    child: Text('Ponto Inacessível'),
                    onPressed: () {
                      // Adicione aqui a ação desejada para quando o botão for pressionado
                      if (podeColetarOuNaoPodeColetar != false) {
                        Navigator.of(context).pop();
                        _ontapInacessivel(marcadorNome, latlng, idPonto);
                      } else {
                        _naoPodeColetarSemIniciarEtapa();
                      }
                    },
                  ),
                ),
            ],
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            // elevation: 5,
          );
        },
      );
    }
  }

  void _naoPodeColetarSemIniciarEtapa() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Atenção!'),
          content:
              Text('Você precisa iniciar uma etapa para poder prosseguir!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(''),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Entendi'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pegaFoto() async {
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
          baseString = base64Image;
        });
      }
    }
  }

  void _ontapInacessivel(
      String marcadorNome, String latlngMarcador, String idPonto) async {
    // var profunidade = pontosMedicao.map((e) => e[])
    // _tiraFoto(marcadorNome, latlngMarcador, true, 'inacessivel');
    _observacaoController.clear();
    var imagem;
    var capturaImagem = ' ';
    var textoCaptura = "Capturar";

    void _adicionaInacessiveis(String idPonto, String marcadorNome,
        String latlngMarcador, String base64imagem, String observacao) {
      // Get the list of profundidades for the given ponto_numero
      var profundidadesList = pontosMedicao.firstWhere((element) =>
          element['pont_numero'] ==
          int.parse(marcadorNome))['profundidades'] as List;

      List<dynamic> lista = FFAppState()
          .trSincroniza
          .where((element) =>
              element['fazenda_id'] == int.parse(widget.fazId!) &&
              element['servico_id'] == int.parse(widget.oservid!))
          .map((e) => e["pontos"])
          .toList()
          .first;

      // Iterate over each profundidade in the list
      for (var profundidade in profundidadesList) {
        setState(() {
          quantidadeDeVezesParaAutoAuditarComFoto--;
          // FFAppState().PontosInacessiveis.add({
          //   "oserv_id": "${widget.oservid}",
          //   "faz_id": "${widget.fazId}",
          //   "id_ponto": idPonto,
          //   "marcador_nome": marcadorNome,
          //   "profundidade": profundidade['pprof_id']
          //       .toString(), // Use the pprof_id from each profundidade
          //   "foto": '$base64imagem',
          //   "latlng": latlngMarcador,
          //   "id_ref": '1',
          //   "obs": observacao,
          //   "data_hora": DateTime.now().toString()
          // });
          //
          // var profundidade2 = profundidade['pprof_id'] as String;
//           print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
// print(profundidade['pprof_id'].toString());
// print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
          var listaFiltrada = lista
              .where((element) =>
                  element["pont_id"] ==
                  int.parse(idPonto) /*Aqui pe o pont_id, id_ponto*/)
              .map((e) => e['profundidades'])
              .first
              .where(
                  (element) => element["pprof_id"] == profundidade['pprof_id'])
              .toList()
              .first; /* == 20321*/ /*aqui é o pprof_id ou profundiadde*/ /*);*/
          var listaSemiFiltrada /*lista antes das profundiades*/ = lista
              .where((element) =>
                  element["pont_id"] ==
                  int.parse(idPonto) /*Aqui pe o pont_id, id_ponto*/)
              .first; /*.map((e) => e['profundidades']).first.where((element) => element["pprof_id"] == 20321).toList().first;*/ /* == 20321*/ /**/ /*aqui é o pprof_id ou profundiadde*/ /**/ /*);*/

          listaFiltrada["pprof_status"] = 2;
          listaFiltrada["pprof_observacao"] = observacao;
          listaFiltrada["pprof_foto"] = '$base64imagem';
          listaFiltrada["pprof_datahora"] = DateTime.now().toString();

          listaSemiFiltrada["pont_status"] = 2;

          List<dynamic> etapas = FFAppState()
              .trSincroniza
              .where((element) =>
                  element['fazenda_id'] == int.parse(widget.fazId!) &&
                  element['servico_id'] == int.parse(widget.oservid!))
              .map((e) => e["etapas"])
              .toList()
              .first;
          var etapaPontos = etapas
              .where((element) =>
                  element["etap_fim"] == "" || element["etap_fim"] == null)
              .toList()
              .first;
          if (etapaPontos['pontos'] == null) {
            etapaPontos['pontos'] = []; // Garante que 'pontos' seja uma lista
          }
          etapaPontos['pontos'].add(listaFiltrada["pprof_id"].toString());

          //adiciona id da etapa no ponto

          listaFiltrada["pprof_etapa_id"] = etapaPontos['etap_id'];
          listaFiltrada["sincronizado"] = "S";
        });
      }
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        // Ajusta o padding superior baseado na altura do teclado, se o teclado estiver visível
        var topPadding = keyboardHeight > 0 ? 110 : 400;

        return AlertDialog(
          // insetPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          // Usa o topPadding dinâmico

          title: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  // Permite que o texto expanda e ocupe o espaço disponível
                  child: Text(
                    'Por que o ponto $marcadorNome está inacessível?',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    // Removido overflow: TextOverflow.ellipsis para permitir quebra de linha
                    softWrap: true,
                    // Habilita a quebra de linha no texto
                    maxLines: null, // Permite um número ilimitado de linhas
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
          content: Padding(
            // padding: EdgeInsets.all(20),

            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _observacaoController,
                  focusNode: _observacaoFocusNode,

                  autofocus: true,
                  maxLines: 4,
                  // Permite múltiplas linhas
                  keyboardType: TextInputType.multiline,
                  // Define o teclado para suportar entrada de texto multilinha
                  decoration: InputDecoration(
                    labelText: 'Observação:',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  capturaImagem,
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
                      onPressed: () async {
                        await _pegaFoto();
                        await Future.delayed(
                            Duration(seconds: 1)); // Simula uma espera

                        setState(() {
                          // Verifica se a string base64 da imagem foi definida
                          if (baseString != null) {
                            textoCaptura = "Capturar";
                            capturaImagem =
                                "Foto capturada! Clique no botão abaixo caso queira capturar novamente.";
                          } else {
                            textoCaptura = "";
                            capturaImagem =
                                'Ops! Algo deu errado. Tente novamente.';
                          }
                        });

                        FocusScope.of(context)
                            .requestFocus(_observacaoFocusNode);
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        primary: Color(0xFF087071), // Cor do botão
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(100), // Bordas arredondadas
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(Icons.photo_camera, color: Colors.white),
                          SizedBox(width: 6),
                          Text(textoCaptura,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10), // Espaçamento entre os botões
                    ElevatedButton(
                      onPressed: () {
                        // Implemente a ação para este botão
                        print(_observacaoController.text);
                        if (_observacaoController.text != null &&
                            _observacaoController.text != "┤├" &&
                            _observacaoController.text != "" &&
                            _observacaoController.text.isNotEmpty &&
                            capturaImagem ==
                                "Foto capturada! Clique no botão abaixo caso queira capturar novamente.") {
                          _atualizaObservacaoDeColetaInacessivel(
                              marcadorNome, _observacaoController.text);
                          FFAppState().PontosTotalmenteColetados.add({
                            "oserv_id": widget.oservid,
                            "faz_id": widget.fazId,
                            "ponto": idPonto.toString(),
                          });
                          _adicionaInacessiveis(
                              idPonto,
                              marcadorNome,
                              latlngMarcador,
                              baseString!,
                              _observacaoController.text);

                          int registros = FFAppState()
                                  .PontosColetados
                                  .where((element) =>
                                      element['oserv_id'] == widget.oservid &&
                                      element['faz_id'] == widget.fazId)
                                  .length +
                              FFAppState()
                                  .PontosInacessiveis
                                  .where((element) =>
                                      element['oserv_id'] == widget.oservid &&
                                      element['faz_id'] == widget.fazId)
                                  .length;
                          var aColetar = pontosMedicao
                              .expand(
                                  (e) => e['profundidades'] as List<dynamic>)
                              .map((profundidade) => profundidade['pprof_id'])
                              .toList();
                          if (registros == aColetar.length) {
                            _finalizouColeta();
                          }

                          baseString = null;
                          textoCaptura = "Capturar";
                          capturaImagem =
                              'Ops! Algo deu errado. Tente novamente.';
                          _observacaoController.clear();
                          Navigator.of(context).pop();
                        } else {
                          _showAlertaImagem();
                          print(_observacaoController);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        primary: Color(0xFF087071), // Cor do botão
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(100), // Bordas arredondadas
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        // Isso garante que o Row não ocupe mais espaço do que o necessário
                        children: [
                          Icon(Icons.arrow_forward, color: Colors.white),
                          // Ícone dentro do botão
                          SizedBox(width: 8),
                          // Espaçamento entre o ícone e o texto
                          Text("Salvar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          // Texto do botão
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          // elevation: 5,
        );
      },
    );
  }

  void _atualizaObservacaoDeColetaInacessivel(
      String marcadorNome, String observacao) async {
    int index = FFAppState()
        .PontosInacessiveis
        .indexWhere((element) => element['marcador_nome'] == marcadorNome);

    // Verifique se um elemento com esse marcadorNome foi encontrado
    if (index != -1) {
      // Atualize a observação desse ponto inacessível
      FFAppState().PontosInacessiveis[index]['obs'] = observacao;
    }

    String svgError =
        '''<svg width="70" height="70" viewBox="0 0 70 70" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M35 70C44.2826 70 53.185 66.3125 59.7487 59.7487C66.3125 53.185 70 44.2826 70 35C70 25.7174 66.3125 16.815 59.7487 10.2513C53.185 3.68749 44.2826 0 35 0C25.7174 0 16.815 3.68749 10.2513 10.2513C3.68749 16.815 0 25.7174 0 35C0 44.2826 3.68749 53.185 10.2513 59.7487C16.815 66.3125 25.7174 70 35 70ZM23.9258 23.9258C25.2109 22.6406 27.2891 22.6406 28.5605 23.9258L34.9863 30.3516L41.4121 23.9258C42.6973 22.6406 44.7754 22.6406 46.0469 23.9258C47.3184 25.2109 47.332 27.2891 46.0469 28.5605L39.6211 34.9863L46.0469 41.4121C47.332 42.6973 47.332 44.7754 46.0469 46.0469C44.7617 47.3184 42.6836 47.332 41.4121 46.0469L34.9863 39.6211L28.5605 46.0469C27.2754 47.332 25.1973 47.332 23.9258 46.0469C22.6543 44.7617 22.6406 42.6836 23.9258 41.4121L30.3516 34.9863L23.9258 28.5605C22.6406 27.2754 22.6406 25.1973 23.9258 23.9258Z" fill="#AA0303"/>
</svg>''';

    var newIcon = await getSvgIcon(svgError!);
    //infowindow de coleta inacessivel
    google_maps.InfoWindow infoWindow;
    infoWindow = google_maps.InfoWindow(
      title: "Ponto Inacessível: " + marcadorNome!.toString(),
      snippet: "Este ponto não pode ser acessado.",
    );
    setState(() {
      markers = markers.map((m) {
        if (m.markerId.value == marcadorNome) {
          return m.copyWith(
              iconParam: newIcon,
              infoWindowParam: infoWindow,
              onTapParam: () {});
        }
        return m;
      }).toSet();
    });
  }

  Future<Uint8List?> convertToWebP(Uint8List imageBytes) async {
    try {
      // Ajuste a qualidade conforme necessário, 0-100
      int quality = 75;
      // Comprime e converte para WebP
      Uint8List? result = await FlutterImageCompress.compressWithList(
        imageBytes,
        quality: quality,
        format: CompressFormat.webp,
      );
      return result;
    } catch (e) {
      print("Erro ao converter para WebP: $e");
      return null;
    }
  }

  void _tiraFoto(String nomeMarcadorAtual, String latlng,
      bool isInacessivelOuNao, String profundidade, String idPonto) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      Uint8List bytes = await image.readAsBytes();
      img.Image? originalImage = img.decodeImage(bytes);
      if (originalImage != null) {
        img.Image resizedImage = img.copyResize(originalImage,
            width: (originalImage.width * 0.23).round(),
            height: (originalImage.height * 0.23).round());

        Uint8List resizedBytes =
            Uint8List.fromList(img.encodePng(resizedImage));

        // Comprime e converte para WebP
        Uint8List? webPBytes = await convertToWebP(resizedBytes);

        if (webPBytes != null) {
          // Converte os bytes da imagem WebP para uma string base64
          String base64Image = base64Encode(webPBytes);
          var etiqueta = _codigoQr.text;

          List<dynamic> etiquetas = FFAppState()
              .trSincroniza
              .where((element) =>
                  element['fazenda_id'] == int.parse(widget.fazId!) &&
                  element['servico_id'] == int.parse(widget.oservid!))
              .map((e) => e["etiquetas"])
              .toList()
              .first;

          bool temOuNaoEtiqueta = false;

// Verifica se a etiqueta existe na lista de etiquetas
          if (etiquetas != null && etiquetas.isNotEmpty) {
            temOuNaoEtiqueta =
                etiquetas.any((etiqueta2) => etiqueta2 == etiqueta);
          }
          if (temOuNaoEtiqueta == false) {
            setState(() {
              if (isInacessivelOuNao) {
                quantidadeDeVezesParaAutoAuditarComFoto--;

                // FFAppState().PontosInacessiveis.add({
                //   "oserv_id": "${widget.oservid}",
                //   "faz_id": "${widget.fazId}",
                //   "id_ponto": idPonto,
                //   "marcador_nome": nomeMarcadorAtual,
                //   "profundidade": 'inacessivel',
                //   // "foto": 'base64ImageInacessivel',
                //   "foto": base64Image,
                //   "latlng": '$latlng',
                //   "obs": "",
                //   "data_hora": DateTime.now().toString()
                // });

                List<dynamic> lista = FFAppState()
                    .trSincroniza
                    .where((element) =>
                        element['fazenda_id'] == int.parse(widget.fazId!) &&
                        element['servico_id'] == int.parse(widget.oservid!))
                    .map((e) => e["pontos"])
                    .toList()
                    .first;

                var listaFiltrada = lista
                    .where((element) =>
                        element["pont_id"] ==
                        int.parse(idPonto) /*Aqui pe o pont_id, id_ponto*/)
                    .map((e) => e['profundidades'])
                    .first
                    .where((element) =>
                        element["pprof_id"] == int.parse(profundidade))
                    .toList()
                    .first; /* == 20321*/ /*aqui é o pprof_id ou profundiadde*/ /*);*/
                var listaSemiFiltrada /*lista antes das profundiades*/ = lista
                    .where((element) =>
                        element["pont_id"] ==
                        int.parse(idPonto) /*Aqui pe o pont_id, id_ponto*/)
                    .first; /*.map((e) => e['profundidades']).first.where((element) => element["pprof_id"] == 20321).toList().first;*/ /* == 20321*/ /**/ /*aqui é o pprof_id ou profundiadde*/ /**/ /*);*/

                listaFiltrada["pprof_status"] = 2;
                listaFiltrada["pprof_observacao"] = "";
                listaFiltrada["pprof_foto"] = '';
                listaFiltrada["pprof_datahora"] = DateTime.now().toString();
                listaFiltrada["pprof_etiqueta_id"] = '$etiqueta';

                listaSemiFiltrada["pont_status"] = 2;
                _codigoQr.clear();
                _observacaoController.clear();
              } else {
                Navigator.of(context).pop(); // Fecha o modal atual
                _showModalObservaFoto(idPonto, nomeMarcadorAtual, profundidade,
                    latlng, base64Image);
                // _mostrarModalSucesso(context, nomeMarcadorAtual);
              }
              // coletasPorMarcador.putIfAbsent(nomeMarcadorAtual, () => {});
              // coletasPorMarcador[nomeMarcadorAtual]!.add(nomeProfundidade);

              // Verifica se todas as profundidades foram coletadas
              var todasProfundidades = pontosMedicao
                  .firstWhere((m) => m["pont_numero"] == nomeMarcadorAtual)[
                      "profundidades"]
                  .map((p) => p["pprof_id"])
                  .toSet();
            });
          } else {
            etiquetaJaUsada();
          }
        }
      }
    }
  }

  void _showModalObservaFoto(String idPonto, String nomeMarcador,
      String profundidade, String latlng, String base64Image) {
    observaFotoController.clear();
// Converte a string base64 em bytes
    Uint8List imageBytes = base64Decode(base64Image);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16, right: 16),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            _codigoQr.clear();
                          },
                          child: Icon(
                            Icons.close,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Text(
                    'Foto da amostra capturada!',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontSize: 18,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(8),
                //   child: Image.memory(
                //     imageBytes,
                //     width: 280,
                //     height: 200,
                //     fit: BoxFit.contain,
                //   ),
                // ),

                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, 0, 0), // Ajuste este valor conforme necessário
                  child: SizedBox(
                    // Envolve o QRView com um SizedBox para dar um tamanho fixo
                    height: 140, // Defina a altura desejada
                    width: double.infinity, // Ocupa toda a largura disponível
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderColor: Color(0xFF00736D),
                        borderRadius: 10,
                        borderLength: 120,
                        borderWidth: 5,
                        overlayColor: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                  child: TextFormField(
                    controller: _codigoQr,
                    autofocus: false,
                    maxLines: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Código:',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                  child: TextFormField(
                    controller: observaFotoController,
                    autofocus: true,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Observação:',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 13),
                  child: Wrap(
                    alignment: WrapAlignment
                        .center, // Center the buttons within the Wrap
                    spacing: 10, // Space between the buttons horizontally
                    runSpacing: 10, // Space between the buttons vertically
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          _codigoQr.clear();
                          _tiraFoto(nomeMarcador, latlng, false, profundidade,
                              idPonto);
                        },
                        icon: Icon(Icons.camera_alt, color: Colors.white),
                        label: Text(
                          'Capturar',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          primary: Color(0xFF087071), // Cor do botão
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                100), // Bordas arredondadas
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // FFAppState().PontosColetados.add({
                          //   "oserv_id": "${widget.oservid}",
                          //   "faz_id": "${widget.fazId}",
                          //   "id_ponto": idPonto,
                          //   "marcador_nome": nomeMarcador,
                          //   "profundidade": profundidade,
                          //   "obs": observaFotoController.text,
                          //   "foto": base64Image,
                          //   "latlng": '$latlng',
                          //   "data_hora": DateTime.now().toString()
                          // });
                          var etiqueta = _codigoQr.text;
                          List<dynamic> etiquetas = FFAppState()
                              .trSincroniza
                              .where((element) =>
                                  element['fazenda_id'] ==
                                      int.parse(widget.fazId!) &&
                                  element['servico_id'] ==
                                      int.parse(widget.oservid!))
                              .map((e) => e["etiquetas"])
                              .toList()
                              .first;

                          bool temOuNaoEtiqueta = false;

// Verifica se a etiqueta existe na lista de etiquetas
                          if (etiquetas != null && etiquetas.isNotEmpty) {
                            temOuNaoEtiqueta = etiquetas
                                .any((etiqueta2) => etiqueta2 == etiqueta);
                          }
                          if (temOuNaoEtiqueta == false) {
                            setState(() {
                              if (_codigoQr.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Ops!'),
                                      content: Text(
                                          'É necessário scanear ou informar o código QR.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Fechar'),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                List<dynamic> lista = FFAppState()
                                    .trSincroniza
                                    .where((element) =>
                                        element['fazenda_id'] ==
                                            int.parse(widget.fazId!) &&
                                        element['servico_id'] ==
                                            int.parse(widget.oservid!))
                                    .map((e) => e["pontos"])
                                    .toList()
                                    .first;

                                var listaFiltrada = lista
                                    .where((element) =>
                                        element["pont_id"] ==
                                        int.parse(
                                            idPonto) /*Aqui pe o pont_id, id_ponto*/)
                                    .map((e) => e['profundidades'])
                                    .first
                                    .where((element) =>
                                        element["pprof_id"] ==
                                        int.parse(profundidade))
                                    .toList()
                                    .first; /* == 20321*/ /*aqui é o pprof_id ou profundiadde*/ /*);*/
                                var listaSemiFiltrada /*lista antes das profundiades*/ = lista
                                    .where((element) =>
                                        element["pont_id"] ==
                                        int.parse(
                                            idPonto) /*Aqui pe o pont_id, id_ponto*/)
                                    .first; /*.map((e) => e['profundidades']).first.where((element) => element["pprof_id"] == 20321).toList().first;*/ /* == 20321*/ /**/ /*aqui é o pprof_id ou profundiadde*/ /**/ /*);*/

                                listaFiltrada["pprof_status"] = 1;
                                listaFiltrada["pprof_observacao"] =
                                    observaFotoController.text;
                                listaFiltrada["pprof_foto"] = '$base64Image';
                                listaFiltrada["pprof_datahora"] =
                                    DateTime.now().toString();
                                listaFiltrada["pprof_etiqueta_id"] =
                                    '$etiqueta';

                                listaSemiFiltrada["pont_status"] = 1;

//atualiza etapas
                                List<dynamic> etapas = FFAppState()
                                    .trSincroniza
                                    .where((element) =>
                                        element['fazenda_id'] ==
                                            int.parse(widget.fazId!) &&
                                        element['servico_id'] ==
                                            int.parse(widget.oservid!))
                                    .map((e) => e["etapas"])
                                    .toList()
                                    .first;
                                var etapaPontos = etapas
                                    .where((element) =>
                                        element["etap_fim"] == "" ||
                                        element["etap_fim"] == null)
                                    .toList()
                                    .first;
                                if (etapaPontos['pontos'] == null) {
                                  etapaPontos['pontos'] =
                                      []; // Garante que 'pontos' seja uma lista
                                }
                                etapaPontos['pontos']
                                    .add(listaFiltrada["pprof_id"].toString());
                                //adiciona id da etapa no ponto

                                listaFiltrada["pprof_etapa_id"] =
                                    etapaPontos['etap_id'];
                                listaFiltrada["sincronizado"] = "S";

                                List<dynamic> trSincEtiquetas = FFAppState()
                                    .trSincroniza
                                    .where((element) =>
                                        element['fazenda_id'] ==
                                            int.parse(widget.fazId!) &&
                                        element['servico_id'] ==
                                            int.parse(widget.oservid!))
                                    .map((e) => e["etiquetas"])
                                    .toList()
                                    .first;
                                trSincEtiquetas.add('$etiqueta');

                                quantidadeDeVezesParaAutoAuditarComFoto--;
                                _codigoQr.clear();
                                observaFotoController.clear();
                                Navigator.of(context).pop();
                                _mostrarModalSucesso(context, nomeMarcador);
                              }
                            });
                          } else {
                            etiquetaJaUsada();
                          }
                        },
                        icon: Icon(Icons.arrow_forward, color: Colors.white),
                        label: Text(
                          'Salvar',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          primary: Color(0xFF087071), // Cor do botão
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                100), // Bordas arredondadas
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmarColeta(
      BuildContext context,
      String marcadorNome,
      String profundidadeNome,
      String latlng,
      String referencialProfundidadePontoId,
      String idPonto) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Atenção!'),
          content: Text('Deseja realmente efetuar essa coleta?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Não'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _coletarProfundidade(marcadorNome, profundidadeNome, latlng,
                    referencialProfundidadePontoId, idPonto);
              },
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  void _coletarProfundidade(String marcadorNome, String profundidadeNome,
      String latlng, String referencialProfundidadePontoId, String idPonto) {
    setState(() {
      if (isPrimeiraColeta == true || _isLastCollect) {
        print("É A PRIMEIRA COLETA");
        print("É A PRIMEIRA COLETA");
        print("É A PRIMEIRA COLETA");
        FFAppState()
            .listaColetasInciadas
            .add({"oserv_id": widget.oservid, "faz_id": widget.fazId});
        _tiraFoto(marcadorNome, latlng, false, profundidadeNome, idPonto);
      } else {
        print("NÃO É A PRIMEIRA COLETA");
        print("NÃO É A PRIMEIRA COLETA");
        print("NÃO É A PRIMEIRA COLETA");
        if (widget.autoAuditoria == true) {
          print("AUTDITORIA TA TRUE!!");
          print("AUTDITORIA TA TRUE!!");
          print("AUTDITORIA TA TRUE!!");
          if (vezAtualDeFoto <= 0) {
            print("VEZ ATUAL DA FOTO ESTA IGUAL OU MENOR QUE ZERO");
            print("VEZ ATUAL DA FOTO ESTA IGUAL OU MENOR QUE ZERO");
            print("VEZ ATUAL DA FOTO ESTA IGUAL OU MENOR QUE ZERO");
            _tiraFoto(marcadorNome, latlng, false, profundidadeNome, idPonto);
          } else {
            print("NÃO É IGUAL OU MENOR QUE ZERO");
            print("NÃO É IGUAL OU MENOR QUE ZERO");
            print("NÃO É IGUAL OU MENOR QUE ZERO");
            quantidadeDeVezesParaAutoAuditarComFoto--;
            // ( ?? 0) - 1;

            _observacaoSemFoto(marcadorNome, latlng, idPonto, profundidadeNome);
          }
        } else {
          print("AUTO AUDITORIA É OFF");
          print("AUTO AUDITORIA É OFF");
          print("AUTO AUDITORIA É OFF");
          quantidadeDeVezesParaAutoAuditarComFoto--;
          // ( ?? 0) - 1;

          _observacaoSemFoto(marcadorNome, latlng, idPonto, profundidadeNome);
        }
      }
    });
    // Navigator.of(context).pop(); // Fecha o modal atual
    // _mostrarModalSucesso(context, marcadorNome);
  }

  bool _validaSeTodasAsProfundidadesForamColetadasNoPontoX(
      String marcadorNome) {
    // var PontosNaoMarcados = pontosMedicao
    //     .where((element) => element['pont_numero'] == int.parse(marcadorNome))
    //     .map((e) => e['profundidades'].toList().length)
    //     .toString();
    // var PontosNaoMarcados2 =
    //     PontosNaoMarcados.replaceAll(")", "").replaceAll("(", "");
    //
    // var PontosColetadosComProf = FFAppState()
    //     .PontosColetados
    //     .where((m) => m["marcador_nome"] == marcadorNome)
    //     .map((e) => e['profundidade'])
    //     .toList()
    //     .length
    //     .toString();
    //
    // bool coletouTodas = PontosColetadosComProf == PontosNaoMarcados2;

    List<dynamic> lista = FFAppState()
        .trSincroniza
        .where((element) =>
            element['fazenda_id'] == int.parse(widget.fazId!) &&
            element['servico_id'] == int.parse(widget.oservid!))
        .map((e) => e["pontos"])
        .toList()
        .first;
    var listaSemiFiltrada = lista
        .where((element) =>
            element["pont_numero"] ==
            int.parse(marcadorNome) /*Aqui pe o pont_id, id_ponto*/)
        .first;
    bool coletouTodas = listaSemiFiltrada["profundidades"]
        .every((element) => element["pprof_status"] == 1);

    return coletouTodas;
  }

  bool _validaSeAlgumasProfundidadesForamColetadasNoPontoX(
      String marcadorNome) {
    // var PontosNaoMarcados = pontosMedicao
    //     .where((element) => element['pont_numero'] == int.parse(marcadorNome))
    //     .map((e) => e['profundidades'].toList().length)
    //     .toString();
    // var PontosNaoMarcados2 =
    //     PontosNaoMarcados.replaceAll(")", "").replaceAll("(", "");
    //
    // var PontosColetadosComProf = FFAppState()
    //     .PontosColetados
    //     .where((m) => m["marcador_nome"] == marcadorNome)
    //     .map((e) => e['profundidade'])
    //     .toList()
    //     .length
    //     .toString();
    //
    // bool coletou = int.parse(PontosColetadosComProf) > 0;

    List<dynamic> lista = FFAppState()
        .trSincroniza
        .where((element) =>
            element['fazenda_id'] == int.parse(widget.fazId!) &&
            element['servico_id'] == int.parse(widget.oservid!))
        .map((e) => e["pontos"])
        .toList()
        .first;
    var listaSemiFiltrada = lista
        .where((element) =>
            element["pont_numero"] ==
            int.parse(marcadorNome) /*Aqui pe o pont_id, id_ponto*/)
        .first;
    bool coletou = listaSemiFiltrada["profundidades"]
        .any((element) => element["pprof_status"] == 1);

    return coletou;
  }

  void _observacaoSemFoto(String marcadorNome, String latlngMarcador,
      String idPonto, String profundidade) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        // Ajusta o padding superior baseado na altura do teclado, se o teclado estiver visível
        var topPadding = keyboardHeight > 0 ? 110 : 400;

        return AlertDialog(
          // insetPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          // Usa o topPadding dinâmico

          title: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Deseja fazer uma observação par o ponto $marcadorNome?',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    _codigoQr.clear();
                  },
                  child: Icon(
                    Icons.close,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),

          content: Padding(
            // padding: EdgeInsets.all(20),

            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, 0, 0), // Ajuste este valor conforme necessário
                  child: SizedBox(
                    // Envolve o QRView com um SizedBox para dar um tamanho fixo
                    height: 140, // Defina a altura desejada
                    width: double.infinity, // Ocupa toda a largura disponível
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                        borderColor: Color(0xFF00736D),
                        borderRadius: 10,
                        borderLength: 120,
                        borderWidth: 5,
                        overlayColor: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: TextFormField(
                    controller: _codigoQr,
                    autofocus: false,
                    maxLines: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Código:',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: _observacaoController,
                  focusNode: _observacaoFocusNode,

                  autofocus: true,
                  maxLines: 4,
                  // Permite múltiplas linhas
                  keyboardType: TextInputType.multiline,
                  // Define o teclado para suportar entrada de texto multilinha
                  decoration: InputDecoration(
                    labelText: 'Observação(opcional): ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Centraliza os botões na Row
                  children: <Widget>[
                    // Espaçamento entre os botões
                    ElevatedButton(
                      onPressed: () {
                        // Implemente a ação para este botão
                        print(_observacaoController.text);

                        var etiqueta = _codigoQr.text;

                        List<dynamic> etiquetas = FFAppState()
                            .trSincroniza
                            .where((element) =>
                                element['fazenda_id'] ==
                                    int.parse(widget.fazId!) &&
                                element['servico_id'] ==
                                    int.parse(widget.oservid!))
                            .map((e) => e["etiquetas"])
                            .toList()
                            .first;

                        // var etiquetaExistente = '1234567899';

                        bool temOuNaoEtiqueta = false;

// Verifica se a etiqueta existe na lista de etiquetas
                        if (etiquetas != null && etiquetas.isNotEmpty) {
                          temOuNaoEtiqueta = etiquetas
                              .any((etiqueta2) => etiqueta2 == etiqueta);
                        }

                        if (temOuNaoEtiqueta == false) {
                          setState(() {
                            if (_codigoQr.text.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Ops!'),
                                    content: Text(
                                        'É necessário scanear ou informar o código QR.'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Fechar'),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              List<dynamic> lista = FFAppState()
                                  .trSincroniza
                                  .where((element) =>
                                      element['fazenda_id'] ==
                                          int.parse(widget.fazId!) &&
                                      element['servico_id'] ==
                                          int.parse(widget.oservid!))
                                  .map((e) => e["pontos"])
                                  .toList()
                                  .first;

                              var listaFiltrada = lista
                                  .where((element) =>
                                      element["pont_id"] ==
                                      int.parse(
                                          idPonto) /*Aqui pe o pont_id, id_ponto*/)
                                  .map((e) => e['profundidades'])
                                  .first
                                  .where((element) =>
                                      element["pprof_id"] ==
                                      int.parse(profundidade))
                                  .toList()
                                  .first; /* == 20321*/ /*aqui é o pprof_id ou profundiadde*/ /*);*/
                              var listaSemiFiltrada /*lista antes das profundiades*/ = lista
                                  .where((element) =>
                                      element["pont_id"] ==
                                      int.parse(
                                          idPonto) /*Aqui pe o pont_id, id_ponto*/)
                                  .first; /*.map((e) => e['profundidades']).first.where((element) => element["pprof_id"] == 20321).toList().first;*/ /* == 20321*/ /**/ /*aqui é o pprof_id ou profundiadde*/ /**/ /*);*/

                              listaFiltrada["pprof_status"] = 1;
                              listaFiltrada["pprof_observacao"] =
                                  observaFotoController.text;
                              listaFiltrada["pprof_foto"] = "";
                              listaFiltrada["pprof_datahora"] =
                                  DateTime.now().toString();
                              listaFiltrada["pprof_etiqueta_id"] = '$etiqueta';

                              listaSemiFiltrada["pont_status"] = 1;

//atualiza etapas
                              List<dynamic> etapas = FFAppState()
                                  .trSincroniza
                                  .where((element) =>
                                      element['fazenda_id'] ==
                                          int.parse(widget.fazId!) &&
                                      element['servico_id'] ==
                                          int.parse(widget.oservid!))
                                  .map((e) => e["etapas"])
                                  .toList()
                                  .first;
                              var etapaPontos = etapas
                                  .where((element) =>
                                      element["etap_fim"] == "" ||
                                      element["etap_fim"] == null)
                                  .toList()
                                  .first;
                              if (etapaPontos['pontos'] == null) {
                                etapaPontos['pontos'] =
                                    []; // Garante que 'pontos' seja uma lista
                              }
                              etapaPontos['pontos']
                                  .add(listaFiltrada["pprof_id"].toString());

                              //adiciona id da etapa no ponto

                              listaFiltrada["pprof_etapa_id"] =
                                  etapaPontos['etap_id'];
                              listaFiltrada["sincronizado"] = "S";

                              List<dynamic> trSincEtiquetas = FFAppState()
                                  .trSincroniza
                                  .where((element) =>
                                      element['fazenda_id'] ==
                                          int.parse(widget.fazId!) &&
                                      element['servico_id'] ==
                                          int.parse(widget.oservid!))
                                  .map((e) => e["etiquetas"])
                                  .toList()
                                  .first;
                              trSincEtiquetas.add('$etiqueta');

                              Navigator.of(context).pop();
                              _codigoQr.clear();
                              _observacaoController.clear();
                              Navigator.of(context).pop();
                              _mostrarModalSucesso(context, marcadorNome);
                            }
                          });
                        } else {
                          etiquetaJaUsada();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        primary: Color(0xFF087071), // Cor do botão
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(100), // Bordas arredondadas
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        // Isso garante que o Row não ocupe mais espaço do que o necessário
                        children: [
                          Icon(Icons.arrow_forward, color: Colors.white),
                          // Ícone dentro do botão
                          SizedBox(width: 8),
                          // Espaçamento entre o ícone e o texto
                          Text("Salvar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          // Texto do botão
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          // elevation: 5,
        );
      },
    );
  }

  void etiquetaJaUsada() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ops!'),
          content: SingleChildScrollView(
            child: SelectableText("Essa etiqueta ja foi usada!"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Entendi'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
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
          title: Text('Concluído!'),
          content: Text('Profundidade coletada com sucesso.'),
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
          borderRadius: BorderRadius.circular(100),
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
        final shouldPop = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Alerta!'),
            content: Text('Você tem certeza que quer sair da coleta?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context)
                    .pop(false), // Não permite sair da tela
                child: Text('Não'),
              ),
              TextButton(
                onPressed: () {
                  // Permite sair da tela e redireciona
                  Navigator.of(context).pop(true); // Primeiro, fecha o diálogo

                  setState(() {
                    _finalizouColeta();
                  });
                },
                child: const Text('Sim'),
              ),
            ],
          ),
        ); // Permite o comportamento padrão de voltar.
        return shouldPop ?? false;
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
          child: Text(
            '${quantidadeDeProfundidadesASeremColetadas ?? "teste"}',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _codigoQr.text = scanData.code!;
        controller?.pauseCamera();
        Done_Button = true;
      });
    });
  }

  void _exibirDados() {
    // int registros = FFAppState()
    //         .PontosColetados
    //         .where((element) =>
    //             element['oserv_id'] == widget.oservid &&
    //             element['faz_id'] == widget.fazId)
    //         .length +
    //     FFAppState()
    //         .PontosInacessiveis
    //         .where((element) =>
    //             element['oserv_id'] == widget.oservid &&
    //             element['faz_id'] == widget.fazId)
    //         .length;
    // var aColetar = pontosMedicao
    //     .expand((e) => e['profundidades'] as List<dynamic>)
    //     .map((profundidade) => profundidade['pprof_id'])
    //     .toList();
    // if (registros == aColetar.length) {
    //   _finalizouColeta();
    // }
    // var colteasTotalmente = FFAppState().PontosTotalmenteColetados;
    // var coletados = FFAppState().trSincroniza.map((e) {
    //   // Cria um novo mapa a partir do mapa original, excluindo a chave 'foto'
    //   var novoMapa = Map.of(e); // Cria uma cópia do mapa
    //   novoMapa.remove('foto'); // Remove a chave 'foto'
    //   return novoMapa; // Retorna o novo mapa sem a chave 'foto'
    // }).toList();
    // var coletados2 = FFAppState().PontosColetados.map((e) {
    //   // Cria um novo mapa a partir do mapa original, excluindo a chave 'foto'
    //   var novoMapa = Map.of(e); // Cria uma cópia do mapa
    //   novoMapa.remove('foto'); // Remove a chave 'foto'
    //   return novoMapa; // Retorna o novo mapa sem a chave 'foto'
    // }).toList();
    // var inacessiveis = FFAppState().PontosInacessiveis.length;
    //
    // var aud = widget.autoAuditoria;
    // var vez = vezAtualDeFoto;
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         // insetPadding: EdgeInsets.zero,
    //         insetPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    //         // Usa o topPadding dinâmico
    //
    //         title: Padding(
    //           padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
    //           child: Row(
    //             mainAxisSize: MainAxisSize.max,
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Expanded(
    //                 child: Text(
    //                   'Leia o QR-Code!',
    //                   style: FlutterFlowTheme.of(context).bodyMedium.override(
    //                         fontFamily: 'Outfit',
    //                         fontSize: 18,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                 ),
    //               ),
    //               InkWell(
    //                 onTap: () => Navigator.of(context).pop(),
    //                 child: Icon(
    //                   Icons.close,
    //                   color: FlutterFlowTheme.of(context).secondaryText,
    //                   size: 32,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         content: Padding(
    //           // padding: EdgeInsets.all(20),
    //
    //           padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Padding(
    //                 padding: EdgeInsets.fromLTRB(
    //                     0, 0, 0, 10), // Ajuste este valor conforme necessário
    //                 child: SizedBox(
    //                   // Envolve o QRView com um SizedBox para dar um tamanho fixo
    //                   height: 180, // Defina a altura desejada
    //                   width: double.infinity, // Ocupa toda a largura disponível
    //                   child: QRView(
    //                     key: qrKey,
    //                     onQRViewCreated: _onQRViewCreated,
    //                     overlay: QrScannerOverlayShape(
    //                       borderColor: Color(0xFF00736D),
    //                       borderRadius: 10,
    //                       borderLength: 130,
    //                       borderWidth: 5,
    //                       overlayColor: Color(0xFFEEEBF5),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               TextField(
    //                 controller: _codigoQr,
    //                 autofocus: false,
    //                 maxLines: 1,
    //                 // Permite múltiplas linhas
    //                 keyboardType: TextInputType.multiline,
    //                 // Define o teclado para suportar entrada de texto multilinha
    //                 decoration: InputDecoration(
    //                   labelText: 'Código: ',
    //                   border: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(10),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(height: 6),
    //               Row(
    //                 mainAxisSize: MainAxisSize.max,
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 // Centraliza os botões na Row
    //                 children: <Widget>[
    //                   ElevatedButton(
    //                     onPressed: () {
    //                       //passar aqui o codigo de abrir esse modal novamente passando as variaveis ponto id, coleta id, etc, profuncidade, latlng
    //                       // Navigator.of(context).pop();
    //                       controller?.resumeCamera();
    //                       _codigoQr.clear();
    //                       // _exibirDados();
    //                     },
    //                     style: ElevatedButton.styleFrom(
    //                       padding:
    //                           EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    //                       primary: Color(0xFF087071), // Cor do botão
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius:
    //                             BorderRadius.circular(100), // Bordas arredondadas
    //                       ),
    //                     ),
    //                     child: Row(
    //                       mainAxisSize: MainAxisSize.min,
    //                       // Isso garante que o Row não ocupe mais espaço do que o necessário
    //                       children: [
    //                         Icon(Icons.refresh, color: Colors.white),
    //                         // Ícone dentro do botão
    //                       ],
    //                     ),
    //                   ),
    //                   ElevatedButton(
    //                     onPressed: () {
    //                       // Implemente a ação para este botão
    //                       Navigator.of(context).pop();
    //                     },
    //                     style: ElevatedButton.styleFrom(
    //                       padding:
    //                           EdgeInsets.symmetric(horizontal: 22, vertical: 10),
    //                       primary: Color(0xFF087071), // Cor do botão
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius:
    //                             BorderRadius.circular(100), // Bordas arredondadas
    //                       ),
    //                     ),
    //                     child: Row(
    //                       mainAxisSize: MainAxisSize.max,
    //                       // Isso garante que o Row não ocupe mais espaço do que o necessário
    //                       children: [
    //                         Icon(Icons.arrow_forward, color: Colors.white),
    //                         // Ícone dentro do botão
    //                         SizedBox(width: 8),
    //                         // Espaçamento entre o ícone e o texto
    //                         Text("Próximo",
    //                             style:
    //                                 TextStyle(color: Colors.white, fontSize: 18)),
    //                         // Texto do botão
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //         backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
    //         // elevation: 5,
    //       );
    //     },
    //   );
    // // }
    // var talhoes = FFAppState().trTalhoesEmCadaServico.firstWhere((registro) =>
    //     registro['fazenda_id'].toString() == widget.fazId! &&
    //     registro['servico_id'].toString() == widget.oservid!)['dados'];
    //
    // var talh2 = FFAppState().trSincroniza.firstWhere((registro) =>
    //     registro['fazenda_id'].toString() == widget.fazId! &&
    //     registro['servico_id'].toString() == widget.oservid!);
    //
    // var jaExisteTrSincroniza = FFAppState()
    //     .trSincroniza
    //     .where((element) =>
    //         element['fazenda_id'] == 1 && element['servico_id'] == 1)
    //     .toList();
    // // var listaIna = FFAppState().PontosInacessiveis.where((element) =>
    // // element['oserv_id'].toString() == '1' &&
    // //     element['faz_id'].toString() == '1');
    //
    // List<dynamic> lista = FFAppState()
    //     .trSincroniza
    //     .where((element) =>
    //         element['fazenda_id'] == int.parse(widget.fazId!) && element['servico_id'] == int.parse(widget.oservid!))
    //     .map((e) => e["pontos"])
    //     .toList()
    //     .first;
    //
    // // var listaFiltrada = lista.where((element) => element["point_id"] != 17429).toList();
    //
    // // var listaSemiFiltrada = lista.where((element) => element["pont_id"] == 17430/*Aqui pe o pont_id, id_ponto*/).first;/*.map((e) => e['profundidades']).first.where((element) => element["pprof_id"] == 20321).toList().first;*//* == 20321*//**//*aqui é o pprof_id ou profundiadde*//**//*);*/
    // // var listaSemiFiltrada = lista.where((element) => element["pont_numero"] == 404/*Aqui pe o pont_id, id_ponto*/).first;/*.map((e) => e['profundidades']).first.where((element) => element["pprof_id"] == 20321).toList().first;*//* == 20321*//**//*aqui é o pprof_id ou profundiadde*//**//*);*/
    // var listaSemiFiltrada =
    //     lista; /*.map((e) => e['profundidades']).first.where((element) => element["pprof_id"] == 20321).toList().first;*/ /* == 20321*/ /**/ /*aqui é o pprof_id ou profundiadde*/ /**/ /*);*/
    // var listaFiltrada = lista
    //     .where((element) =>
    //         element["pont_id"] == 17430 /*Aqui pe o pont_id, id_ponto*/)
    //     .map((e) => e['profundidades'])
    //     .first
    //     .where((element) => element["pprof_id"] == 20322)
    //     .toList()
    //     .first; /* == 20321*/ /*aqui é o pprof_id ou profundiadde*/ /*);*/

    // bool allCollected = listaSemiFiltrada["profundidades"].every((element) => element["pprof_status"] == 1);
    // print(listaSemiFiltrada["profundidades"].length); // Print the length of profundidades
    // print(allCollected); // Print the length of profundidades
    //
    // // });
    // var jaColetada = listaFiltrada["pprof_status"].toString();
    //
    // var marcador = pontosMedicao.firstWhere(
    //       (m) => m["pont_numero"] == 399,
    //   orElse: () =>
    //   <String, Object>{}, // Correção aqui para alinhar com o tipo esperado
    // );
    // var profundiade = marcador['profundidades'].toString();
    // var qts = widget.quantidadeAutoAuditoria.toString();

    List<dynamic> trSincComS = FFAppState()
        .trSincroniza
        .where((element) =>
            element['fazenda_id'] == int.parse(widget.fazId!) &&
            element['servico_id'] == int.parse(widget.oservid!))
        .map((e) => e["pontos"])
        .toList()
        .first;

// var trSincComS2 = trSincComS.where((element) => element['profundidades'] != "S").toList();
// var trSincComS2 = trSincComS.map((element) => element['profundidades']).toList();
//
//     List<dynamic> trSincTudoJunto = [];
//     for (var item in trSincComS) {
//       // Supondo que cada 'item' em 'trSincComS' tenha uma chave 'profundidades' que é uma lista
//       trSincTudoJunto.addAll(item.where((e)=> e['profundidades']['sincronizado'] != "N"));
//     }

    List<dynamic> trSincTudoJunto = [];
    for (var item in trSincComS) {
      // Verifica se o item tem a chave 'profundidades' e se é uma lista
      if (item.containsKey('profundidades') && item['profundidades'] is List) {
        // Filtra as profundidades onde 'sincronizado' é diferente de "N"
        var profundidadesFiltradas = item['profundidades']
            .where((profundidade) => profundidade['sincronizado'] != "N")
            .toList();

        // Se profundidadesFiltradas não está vazia, adicione o item a trSincTudoJunto
        if (profundidadesFiltradas.isNotEmpty) {
          // Aqui você pode decidir se quer adicionar o item inteiro ou apenas as profundidades filtradas
          trSincTudoJunto.add(item); // Adiciona o item inteiro
          // Se quiser adicionar apenas as profundidades filtradas, use a linha abaixo
          // trSincTudoJunto.addAll(profundidadesFiltradas);
        }
      }
    }

// var trSincComS3 = trSincComS2.map((e) => e['sincronizado']).toList();

//
//     List<dynamic> etapas = FFAppState()
//         .trSincroniza
//         .where((element) =>
//             element['fazenda_id'] == int.parse(widget.fazId!) &&
//             element['servico_id'] == int.parse(widget.oservid!))
//         .map((e) => e["etapas"])
//         .toList()
//         .first;
//
//     var etapaPontos = etapas
//         .where((element) =>
//             element["etap_fim"] == "" || element["etap_fim"] == null)
//         .toList()
//         .first;
//
//     List<dynamic> etiquetas = FFAppState()
//         .trSincroniza
//         .where((element) =>
//             element['fazenda_id'] == int.parse(widget.fazId!) &&
//             element['servico_id'] == int.parse(widget.oservid!))
//         .map((e) => e["etiquetas"])
//         .toList()
//         .first;
//
//     var etiquetaExistente = '1234567899';
//
//     bool temOuNaoEtiqueta = false;
//
// // Verifica se a etiqueta existe na lista de etiquetas
//     if (etiquetas != null && etiquetas.isNotEmpty) {
//       temOuNaoEtiqueta =
//           etiquetas.any((etiqueta) => etiqueta == etiquetaExistente);
//     }
//
//     print(temOuNaoEtiqueta ? "Etiqueta existe" : "Etiqueta não existe");
// // etapaPontos['pontos'].add({"NUMERO DO PONTO"});
//
//     var index = FFAppState().trSincroniza.indexOf(FFAppState()
//         .trSincroniza
//         .firstWhere((registro) =>
//             registro['fazenda_id'].toString() == widget.fazId! &&
//             registro['servico_id'].toString() == widget.oservid!));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aproxime-se do ponto!'),
          content: SingleChildScrollView(
            child: SelectableText(trSincsS.toString()),
          ),
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
}
