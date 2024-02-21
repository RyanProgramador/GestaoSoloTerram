import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';

LatLng? listaStrToListaLatLng(
  String? latitude,
  String? longitude,
) {
  if (latitude == null || longitude == null) return null;

  try {
    final double lat = double.parse(latitude);
    final double lng = double.parse(longitude);
    return LatLng(lat, lng);
  } catch (e) {
    // Em caso de erro na conversão, retorna null
    return null;
  }
}

int? contadorDeIntensNaLista(List<dynamic>? lista) {
  if (lista == null) {
    return 0;
  } else {
    return lista.length;
  }
}
