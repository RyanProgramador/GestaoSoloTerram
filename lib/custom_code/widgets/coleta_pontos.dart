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
  @override
  void initState() {
    super.initState();
    if (widget.fazLatlng != null) {
      initialLatLng = google_maps.LatLng(
          widget.fazLatlng!.latitude, // Usa ! para assegurar que não é nulo
          widget.fazLatlng!.longitude);
    }
    _adicionaPoligonos();
    _getCurrentLocation();
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
        polygonId: google_maps.PolygonId(
            'polygon_${talhao['id']}'), // Supondo que cada talhão tenha um identificador único 'id'
        points: pontos,
        strokeColor: Colors.red, // Cor da linha
        fillColor: Colors.red
            .withOpacity(0.5), // Cor de preenchimento com transparência
        strokeWidth: 1, // Espessura da linha
      );

      setState(() {
        polygons.add(polygon);
      });
    }
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
    var listaTalh =
        FFAppState().trTalhoes.expand((e) => e['coordenadas']).toList();

    List<google_maps.LatLng> teste = [];

    // Dart usa 'for' para iterar sobre listas, ao invés de 'foreach'
    for (var item in listaTalh) {
      // Supondo que cada 'item' é um mapa com as chaves 'talcot_latitude' e 'talcot_longitude'
      var cord = google_maps.LatLng(
        double.parse(item['talcot_latitude']),
        double.parse(item['talcot_longitude']),
      );
      teste.add(cord);
    }
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
                  "Pontos:${teste}",
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
