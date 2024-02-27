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
import 'package:intl/intl.dart';

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
  final bool? autoAuditoria;
  final String? quantidadeAutoAuditoria;
  final List<dynamic>? pontos;

  @override
  State<ColetaPontos> createState() => _ColetaPontosState();
}

class _ColetaPontosState extends State<ColetaPontos> {
  final FocusNode _observacaoFocusNode = FocusNode();
  final FocusNode observaFotoFocusNode = FocusNode();

  Map<String, dynamic> jsonSincronizaPosterior = {};

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

  @override
  void initState() {
    Wakelock.enable();
    super.initState();
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

// Para converter uma String para int
//     if (widget.quantidadeAutoAuditoria != null) {
    quantidadeDeVezesParaAutoAuditarComFoto = 3;
    // int.tryParse(widget.quantidadeAutoAuditoria!)!;
    // }
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
    observaFotoController.dispose();
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
      var idPonto = pontos['point_id'].toString();
      var markerId = google_maps.MarkerId(pontos["pont_numero"]!.toString());
      var coletouTodas = _validaSeTodasAsProfundidadesForamColetadasNoPontoX(
          pontos["pont_numero"]!.toString());

      // final String? svgStr = FFAppState().trIcones.firstWhere(
      //       (element) => element['ico_valor'] == pontos['pont_simbolo'],
      //       orElse: () => {'ico_svg': null},
      //     )['ico_svg'];
      // final google_maps.BitmapDescriptor icon = await getSvgIcon(svgStr!);
      //
      // if(FFAppState().PontosInacessiveis.contains((element) => element["pont_numero"]){
      //
      //   final icon = await BitmapDescriptor.fromAssetImage(
      // ImageConfiguration(size: Size(24, 24)), 'assets/images/favicon.png');
      //
      // }
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
      bool isPontoInacessivel = FFAppState().PontosInacessiveis.any((element) =>
          element["marcador_nome"] == pontos['pont_numero'].toString());

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

  void _finalizouColeta() {
    var lista = FFAppState().PontosColetados.where((element) =>
        element['oserv_id'] == widget.oservid &&
        element['faz_id'] == widget.fazId);

    Map<int, List<Map<String, dynamic>>> groupedByPontoId = {};

    for (var item in lista) {
      // Tenta converter o valor de item["id_ponto"] para int, se não for possível, atribui 0 ou trata o erro de outra forma.
      int idPonto = (int.parse(item["id_ponto"]) as int?) ?? 0;

      if (!groupedByPontoId.containsKey(idPonto)) {
        groupedByPontoId[idPonto] = [];
      }
      groupedByPontoId[idPonto]!.add(item);
    }

    List<Map<String, dynamic>> transformedList = [];

    groupedByPontoId.forEach((idPonto, items) {
      var profundidades = items
          .map((item) => {
                "id": item["profundidade"],
                "status": 1,
                "obs": item["obs"].toString() ?? "Sem observação!",
                "foto": item["foto"].toString() ?? "",
                "data": formatDateTime(item["data_hora"].toString()),
              })
          .toList();

      transformedList.add({
        "id": idPonto,
        "status": 1,
        "obs": items.first["obs"].toString(),
        "foto": items.first["foto"].toString(),
        "profundidades": profundidades,
      });
    });

    var listaIna = FFAppState().PontosInacessiveis.where((element) =>
        element['oserv_id'] == widget.oservid &&
        element['faz_id'] == widget.fazId);

    Map<int, List<Map<String, dynamic>>> groupedByPontoIdInacessivel = {};

    for (var item in listaIna) {
      // Tenta converter o valor de item["id_ponto"] para int, se não for possível, atribui 0 ou trata o erro de outra forma.
      int idPonto = (int.parse(item["id_ponto"]) as int?) ?? 0;

      if (!groupedByPontoIdInacessivel.containsKey(idPonto)) {
        groupedByPontoIdInacessivel[idPonto] = [];
      }
      groupedByPontoIdInacessivel[idPonto]!.add(item);
    }

    List<Map<String, dynamic>> transformedListInacessiveis = [];

    groupedByPontoIdInacessivel.forEach((idPonto, items) {
      var profundidades = items
          .map((item) => {
                "id": item["profundidade"],
                "status": 2,
                "obs": item["obs"].toString() ?? "Sem observação!",
                "foto": item["foto"].toString() ?? "",
                "data": formatDateTime(item["data_hora"].toString()),
              })
          .toList();

      transformedListInacessiveis.add({
        "id": idPonto,
        "status": 2,
        "obs": items.first["obs"].toString(),
        "foto": items.first["foto"].toString(),
        "profundidades": profundidades,
      });
    });

    var jaExisteTrSincroniza = FFAppState()
        .trSincroniza
        .where((element) =>
            element['fazenda_id'] == widget.fazId.toString() &&
            element['servico_id'] == widget.oservid.toString())
        .toList();

// Checa se algum elemento foi encontrado
    if (jaExisteTrSincroniza.isNotEmpty) {
      // Atualiza o primeiro elemento encontrado
      // Esta é uma abordagem simplificada; ajuste conforme a necessidade de sua aplicação
      int index = FFAppState().trSincroniza.indexOf(jaExisteTrSincroniza.first);
      if (index != -1) {
        // Verifica se encontrou o índice corretamente
        FFAppState().trSincroniza[index] = {
          "fazenda_id": widget.fazId.toString(),
          "servico_id": widget.oservid.toString(),
          "pontos": transformedList + transformedListInacessiveis,
        };
      }
    } else {
      // Adiciona um novo elemento, pois não foi encontrado nenhum correspondente
      FFAppState().trSincroniza.add({
        "fazenda_id": widget.fazId.toString(),
        "servico_id": widget.oservid.toString(),
        "pontos": transformedList + transformedListInacessiveis,
      });
    }

    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text('Finalizou coletas!'),
    //       content: Text('Todos os pontos foram vistoriados.'),
    //       actions: <Widget>[
    //         TextButton(
    //           child: Text('OK'),
    //           onPressed: () {
    //             Navigator.of(context).pop(); // Close the dialog
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
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

                  bool jaColetada = //false;
                      FFAppState().PontosColetados.any((pontoColetado) {
                    return pontoColetado['marcador_nome'].toString() ==
                            marcadorNome.toString() &&
                        pontoColetado['profundidade'].toString() ==
                            profundidade['pprof_id'].toString();
                  });

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
                            _confirmarColeta(
                                context,
                                marcadorNome,
                                profundidade["pprof_id"].toString(),
                                latlng,
                                referencialProfundidadePontoId,
                                idPonto);
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
                      Navigator.of(context).pop();
                      _ontapInacessivel(marcadorNome, latlng, idPonto);
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

      // Iterate over each profundidade in the list
      for (var profundidade in profundidadesList) {
        setState(() {
          quantidadeDeVezesParaAutoAuditarComFoto--;
          FFAppState().PontosInacessiveis.add({
            "oserv_id": "${widget.oservid}",
            "faz_id": "${widget.fazId}",
            "id_ponto": idPonto,
            "marcador_nome": marcadorNome,
            "profundidade": profundidade['pprof_id']
                .toString(), // Use the pprof_id from each profundidade
            "foto": '$base64imagem',
            "latlng": latlngMarcador,
            "id_ref": '1',
            "obs": observacao,
            "data_hora": DateTime.now().toString()
          });
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
                    softWrap: true, // Habilita a quebra de linha no texto
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
                        // Implemente a lógica para capturar foto
                        // Navigator.of(context).pop();
                        // _tiraFoto(marcadorNome, latlngMarcador, true);
                        // _tiraFoto(marcadorNome, latlngMarcador, true, 'inacessivel');

                        await _pegaFoto();
                        await Future.delayed(
                            Duration(seconds: 1)); // Simula uma espera

                        setState(() {
                          // Verifica se a string base64 da imagem foi definida
                          if (baseString != null) {
                            textoCaptura = "Novamente";
                            capturaImagem =
                                "Foto capturada! Clique no botão abaixo caso queira capturar novamente.";
                          } else {
                            textoCaptura = "Capturar";
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

    // var iconBytes = resizeImage(
    //     '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',
    //     80,
    //     80);

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

  void _tiraFoto(String nomeMarcadorAtual, String latlng,
      bool isInacessivelOuNao, String profundidade, String idPonto) async {
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
          if (isInacessivelOuNao) {
            quantidadeDeVezesParaAutoAuditarComFoto--;

            FFAppState().PontosInacessiveis.add({
              "oserv_id": "${widget.oservid}",
              "faz_id": "${widget.fazId}",
              "id_ponto": idPonto,
              "marcador_nome": nomeMarcadorAtual,
              "profundidade": 'inacessivel',
              // "foto": 'base64ImageInacessivel',
              "foto": base64Image,
              "latlng": '$latlng',
              "obs": "",
              "data_hora": DateTime.now().toString()
            });
            _observacaoController.clear();
          } else {
            // FFAppState().PontosColetados.add({
            //   "id_ponto": idPonto,
            //   "marcador_nome": nomeMarcadorAtual,
            //   "profundidade": profundidade,
            //   "obs": "",
            //   "foto": 'base64Image',
            //   "profundidade": profundidade,
            //   "latlng": '$latlng',
            //   "data_hora": DateTime.now().toString()
            // });
            Navigator.of(context).pop(); // Fecha o modal atual
            _showModalObservaFoto(
                idPonto, nomeMarcadorAtual, profundidade, latlng, base64Image);
            // _mostrarModalSucesso(context, nomeMarcadorAtual);
          }
          // coletasPorMarcador.putIfAbsent(nomeMarcadorAtual, () => {});
          // coletasPorMarcador[nomeMarcadorAtual]!.add(nomeProfundidade);

          // Verifica se todas as profundidades foram coletadas
          var todasProfundidades = pontosMedicao
              .firstWhere(
                  (m) => m["pont_numero"] == nomeMarcadorAtual)["profundidades"]
              .map((p) => p["pprof_id"])
              .toSet();
        });
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
                          onTap: () => Navigator.of(context).pop(),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    imageBytes,
                    width: 280,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: TextFormField(
                    controller: observaFotoController,
                    autofocus: true,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Observação:',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Wrap(
                    alignment: WrapAlignment
                        .center, // Center the buttons within the Wrap
                    spacing: 10, // Space between the buttons horizontally
                    runSpacing: 10, // Space between the buttons vertically
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          _tiraFoto(nomeMarcador, latlng, false, profundidade,
                              idPonto);
                        },
                        icon: Icon(Icons.camera_alt, color: Colors.white),
                        label: Text(
                          'Novamente',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 10),
                          primary: Color(0xFF087071), // Cor do botão
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                100), // Bordas arredondadas
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          FFAppState().PontosColetados.add({
                            "oserv_id": "${widget.oservid}",
                            "faz_id": "${widget.fazId}",
                            "id_ponto": idPonto,
                            "marcador_nome": nomeMarcador,
                            "profundidade": profundidade,
                            "obs": observaFotoController.text,
                            "foto": base64Image,
                            "latlng": '$latlng',
                            "data_hora": DateTime.now().toString()
                          });
                          quantidadeDeVezesParaAutoAuditarComFoto--;

                          observaFotoController.clear();
                          Navigator.of(context).pop();
                          _mostrarModalSucesso(context, nomeMarcador);
                        },
                        icon: Icon(Icons.arrow_forward, color: Colors.white),
                        label: Text(
                          'Salvar',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 10),
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
      if (isPrimeiraColeta == true) {
        FFAppState()
            .listaColetasInciadas
            .add({"oserv_id": widget.oservid, "faz_id": widget.fazId});
        _tiraFoto(marcadorNome, latlng, false, profundidadeNome, idPonto);
      } else {
        if (widget.autoAuditoria == true) {
          if (vezAtualDeFoto <= 0) {
            _tiraFoto(marcadorNome, latlng, false, profundidadeNome, idPonto);
          } else {
            quantidadeDeVezesParaAutoAuditarComFoto--;
            // ( ?? 0) - 1;

            // FFAppState().PontosColetados.add({
            //   "oserv_id": "${widget.oservid}",
            //   "faz_id": "${widget.fazId}",
            //   "id_ponto": idPonto,
            //   "marcador_nome": marcadorNome,
            //   "profundidade": profundidadeNome,
            //   "obs": "",
            //   "foto": "",
            //   // "profundidade": profundidadeNome,
            //   // "foto": 'base64Fixada',
            //   "latlng": '$latlng',
            //   "data_hora": DateTime.now().toString()
            // });
            // Navigator.of(context).pop(); // Fecha o modal atual
            // _mostrarModalSucesso(context, marcadorNome);

            _observacaoSemFoto(marcadorNome, latlng, idPonto, profundidadeNome);
          }
        } else {
          quantidadeDeVezesParaAutoAuditarComFoto--;
          // ( ?? 0) - 1;

          // FFAppState().PontosColetados.add({
          //   "oserv_id": "${widget.oservid}",
          //   "faz_id": "${widget.fazId}",
          //   "id_ponto": idPonto,
          //   "marcador_nome": marcadorNome,
          //   "profundidade": profundidadeNome,
          //   "obs": "",
          //   "foto": "",
          //   // "profundidade": profundidadeNome,
          //   // "foto": '$base64Fixada',
          //   "latlng": '$latlng',
          //   "data_hora": DateTime.now().toString()
          // });
          // Navigator.of(context).pop(); // Fecha o modal atual
          // _mostrarModalSucesso(context, marcadorNome);

          _observacaoSemFoto(marcadorNome, latlng, idPonto, profundidadeNome);
        }
      }
    });
    // Navigator.of(context).pop(); // Fecha o modal atual
    // _mostrarModalSucesso(context, marcadorNome);
  }

  bool _validaSeTodasAsProfundidadesForamColetadasNoPontoX(
      String marcadorNome) {
    var PontosNaoMarcados = pontosMedicao
        .where((element) => element['pont_numero'] == int.parse(marcadorNome))
        .map((e) => e['profundidades'].toList().length)
        .toString();
    var PontosNaoMarcados2 =
        PontosNaoMarcados.replaceAll(")", "").replaceAll("(", "");

    var PontosColetadosComProf = FFAppState()
        .PontosColetados
        .where((m) => m["marcador_nome"] == marcadorNome)
        .map((e) => e['profundidade'])
        .toList()
        .length
        .toString();

    bool coletouTodas = PontosColetadosComProf == PontosNaoMarcados2;

    return coletouTodas;
  }

  bool _validaSeAlgumasProfundidadesForamColetadasNoPontoX(
      String marcadorNome) {
    var PontosNaoMarcados = pontosMedicao
        .where((element) => element['pont_numero'] == int.parse(marcadorNome))
        .map((e) => e['profundidades'].toList().length)
        .toString();
    var PontosNaoMarcados2 =
        PontosNaoMarcados.replaceAll(")", "").replaceAll("(", "");

    var PontosColetadosComProf = FFAppState()
        .PontosColetados
        .where((m) => m["marcador_nome"] == marcadorNome)
        .map((e) => e['profundidade'])
        .toList()
        .length
        .toString();

    bool coletou = int.parse(PontosColetadosComProf) > 0;

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
                  onTap: () => Navigator.of(context).pop(),
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

                        FFAppState().PontosColetados.add({
                          "oserv_id": "${widget.oservid}",
                          "faz_id": "${widget.fazId}",
                          "id_ponto": idPonto,
                          "marcador_nome": marcadorNome,
                          "profundidade": profundidade,
                          "obs": _observacaoController.text.toString(),
                          "foto": "",
                          // "profundidade": profundidadeNome,
                          // "foto": 'base6''4Fixada',
                          "latlng": latlngMarcador,
                          "data_hora": DateTime.now().toString()
                        });
                        Navigator.of(context).pop();
                        _observacaoController.clear();
                        Navigator.of(context).pop();
                        _mostrarModalSucesso(context, marcadorNome);
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

  void _exibirDados() {
    // var listaTalh = FFAppState().trTalhoes.expend((e) => e[''coordenadas]).toList();
    // var pontos = widget.pontos!.map((e) => e['pont_id']);
    // var marcador = pontosMedicao.firstWhere(
    //   (m) => m["pont_numero"] == 381,
    //   orElse: () =>
    //       <String, Object>{}, // Correção aqui para alinhar com o tipo esperado
    // );
    //
    // var pontosin = FFAppState().PontosInacessiveis;
    // var PontosNaoMarcados = pontosMedicao
    //     .where((element) => element['pont_numero'] == 468)
    //     .map((e) => e['profundidades'].toList().length)
    //     .toString();
    // var PontosNaoMarcados2 =
    //     PontosNaoMarcados.replaceAll(")", "").replaceAll("(", "");
    // // var teste = ;
    //
    // // var erro = FFAppState().PontosInacessiveis.any((element) => element["marcador_nome"] == '454');
    // // List<google_maps.LatLng> teste = [];
    //
    // var qutsAutoAudi = widget.autoAuditoria;
    // var autoAudi = widget.quantidadeAutoAuditoria;
    // // var estaoTodasProfundidadesColetadasNoMarcadoX = FFAppState().PontosColetados.contains((element) => element["marcador_nome"] == '454')
    //
    // // Verifica se todas as profundidades foram coletadas
    // var estaoTodasProfundidadesColetadasNoMarcadoX = FFAppState()
    //     .PontosColetados
    //     .where((m) => m["marcador_nome"] == '468')
    //     .map((e) => e['profundidade'])
    //     .toList()
    //     .length
    //     .toString();
    // bool coletouTodas =
    //     estaoTodasProfundidadesColetadasNoMarcadoX == PontosNaoMarcados2;
    // if (coletasPorMarcador[marcadorNome]!.containsAll(todasProfundidades)) {
    //   // Todas as profundidades coletadas, mude a cor do marcador para verde
    //   _updateMarkerColor(marcadorNome, true);
    //   setState(() {
    //     vezAtualDoIntervaloDeColeta += 1;
    //   });
    // }

    // Dart usa 'for' para iterar sobre listas, ao invés de 'foreach'
    // for (var item in listaTalh) {
    //   // Supondo que cada 'item' é um mapa com as chaves 'talcot_latitude' e 'talcot_longitude'
    //   var cord = google_maps.LatLng(
    //     double.parse(item['talcot_latitude']),
    //     double.parse(item['talcot_longitude']),
    //   );
    //   teste.add(cord);
    // }

    List<Map<String, dynamic>> json = [
      {
        "pont_id": 13423,
        "pont_numero": 404,
        "pont_latitude": "-17.783655786",
        "pont_longitude": "-51.05589056",
        "pont_simbolo": "Pin, Green",
        "profundidades": [
          {
            "pprof_id": 16157,
            "pprof_status": "Pendente",
            "pprof_icone": "Pin, Blue"
          },
          {
            "pprof_id": 16158,
            "pprof_status": "Pendente",
            "pprof_icone": "Pin, Green"
          }
        ]
      },
      {
        "pont_id": 13424,
        "pont_numero": 424,
        "pont_latitude": "-17.788035573",
        "pont_longitude": "-51.045238875",
        "pont_simbolo": "Pin, Green",
        "profundidades": [
          {
            "pprof_id": 16159,
            "pprof_status": "Pendente",
            "pprof_icone": "Pin, Blue"
          },
          {
            "pprof_id": 16160,
            "pprof_status": "Pendente",
            "pprof_icone": "Pin, Green"
          }
        ]
      }
    ];
//     // var teste2 = FFAppState().PontosColetados.any((ponto) => ponto['profundidade'] == '16157');
//     var allColetadosOuInacessiveis = FFAppState()
//         .PontosColetados
//         .any((ponto) => ponto['profundidade'] == '16157');
//
//     var jsonColetados = jsonSincronizaPosterior.toString();
//     // var pontosColetados2 = FFAppState().PontosColetados.map((e) => e['profundidade']);
//
//
//
//
//
//     // var pontosASeremColetados= pontosMedicao.map((e) => e['profundidades'] as List<dynamic>).toList();
//     // // dentro de pontosASeremColetados é uma lista assim: [{"pprof_id": 123, "pprof_status" : "Pendente", "pprof_icone" : "icone_1"}]
//     // var pontosColetados2 = FFAppState().PontosColetados;//map((e) => e["profundidade"]);
//     //
//
//
//     // Supondo que pontosMedicao e FFAppState().PontosColetados já estejam definidos
//     // var pontosASeremColetados = pontosMedicao.expand((e) => e['profundidades'] as List<dynamic>).toList();
//     // var totalPprofId = pontosASeremColetados.length;
//     // print("Total de pprof_id a serem coletados: $totalPprofId");
//     //
//     // var pontosColetados2 = FFAppState().PontosColetados.map((e) => e["profundidade"]).toList();
//     // var totalPontosColetados = pontosColetados2.length;
//     // print("Total de pontos coletados: $totalPontosColetados");
//     //
//     // // Calculando os pontos que faltam ser coletados
//     // var idsProfundidadesColetadas = pontosColetados2.toSet();
//     // var PontosQueFaltamSerColetados = pontosASeremColetados
//     //     .where((ponto) => !idsProfundidadesColetadas.contains(ponto['pprof_id']))
//     //     .toList();
//     //
//     // print("Pontos que faltam ser coletados: ${PontosQueFaltamSerColetados.length}");
//     // print(PontosQueFaltamSerColetados);
//
//
//
//
//
//
//     var pontosASeremColetados = pontosMedicao
//         .expand((e) => e['profundidades'] as List<dynamic>)
//         .map((profundidade) => profundidade['pprof_id'])
//         .toList();
// // esse pontosASeremColetados retorna [123, 124, 125, 126];
//
//     var pontosColetados2 = FFAppState().PontosColetados.map((e) => e["profundidade"]).toList();
// // esse pontosColetados2 retorna [123, 124];
//
//
//
//
//     // Encontra a quantidade de pontos em pontosColetados2 que estão em pontosASeremColetados
//     var pontosJaColetados = pontosColetados2.where((ponto) => pontosASeremColetados.contains(ponto)).toList().toString();
//     print("Quantidade de pontos em pontosColetados2 que estão em pontosASeremColetados: ${pontosJaColetados.length}");
//
//     // Encontra os pontos em pontosASeremColetados que não estão em pontosColetados2
//     var pontosFaltantes = pontosASeremColetados.where((ponto) => !pontosColetados2.contains(ponto)).toList().toString();
//     print("Pontos em pontosASeremColetados que não estão em pontosColetados2: $pontosFaltantes");
//
//     // var totalProfundidades = 0;
//     // for (var profundidadesDeCadaPonto in pontosASeremColetados) {
//     //   totalProfundidades += profundidadesDeCadaPonto.length; // Corrigido para acumular o total corretamente
//     // }
//     //
//     // var quantidadeDeProfundidadesASeremColetadas = totalProfundidades;

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

    var coletados = FFAppState().trSincroniza.map((e) {
      // Cria um novo mapa a partir do mapa original, excluindo a chave 'foto'
      var novoMapa = Map.of(e); // Cria uma cópia do mapa
      novoMapa.remove('foto'); // Remove a chave 'foto'
      return novoMapa; // Retorna o novo mapa sem a chave 'foto'
    }).toList();
    var inacessiveis = FFAppState().PontosInacessiveis.length;
    // var aColetar = pontosMedicao
    //     .expand((e) => e['profundidades'] as List<dynamic>)
    //     .map((profundidade) => profundidade['pprof_id'])
    //     .toList();
    var coletasIniciadas = FFAppState().listaColetasInciadas.firstWhere(
        (element) =>
            element['oserv_id'] == widget.oservid &&
            element['faz_id'] == widget.fazId);
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
                  "Json:}",
                  style: TextStyle(color: Colors.black, fontSize: 12.0),
                ),
                Text(
                  "Pontos coletas iniciadas:${coletados}",
                  style: TextStyle(color: Colors.black, fontSize: 12.0),
                ),
                Text(
                  "Pontos coleados:${registros}",
                  style: TextStyle(color: Colors.black, fontSize: 12.0),
                ),
                Text(
                  "Pontos a serem Coletados:${aColetar.length} ",
                  style: TextStyle(color: Colors.black, fontSize: 12.0),
                ),
                // Text(
                //   "Pontos:${coletouTodas}",
                //   style: TextStyle(color: Colors.black, fontSize: 12.0),
                // ),
                // Text(
                //   "Pontos:${pontosin}",
                //   style: TextStyle(color: Colors.black, fontSize: 12.0),
                // ),
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
