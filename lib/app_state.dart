import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _UrlApi = prefs.getString('ff_UrlApi') ?? _UrlApi;
    });
    _safeInit(() {
      _trOsServicos = prefs.getStringList('ff_trOsServicos')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _trOsServicos;
    });
    _safeInit(() {
      _trIcones = prefs.getStringList('ff_trIcones')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _trIcones;
    });
    _safeInit(() {
      _trTalhoes = prefs.getStringList('ff_trTalhoes')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _trTalhoes;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _UrlApi =
      's://dev.conceittosistemas.com.br/scriptcase/app/GestaoColetas/api/index.php';
  String get UrlApi => _UrlApi;
  set UrlApi(String value) {
    _UrlApi = value;
    prefs.setString('ff_UrlApi', value);
  }

  List<dynamic> _trOsServicos = [];
  List<dynamic> get trOsServicos => _trOsServicos;
  set trOsServicos(List<dynamic> value) {
    _trOsServicos = value;
    prefs.setStringList(
        'ff_trOsServicos', value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrOsServicos(dynamic value) {
    _trOsServicos.add(value);
    prefs.setStringList(
        'ff_trOsServicos', _trOsServicos.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrOsServicos(dynamic value) {
    _trOsServicos.remove(value);
    prefs.setStringList(
        'ff_trOsServicos', _trOsServicos.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrOsServicos(int index) {
    _trOsServicos.removeAt(index);
    prefs.setStringList(
        'ff_trOsServicos', _trOsServicos.map((x) => jsonEncode(x)).toList());
  }

  void updateTrOsServicosAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trOsServicos[index] = updateFn(_trOsServicos[index]);
    prefs.setStringList(
        'ff_trOsServicos', _trOsServicos.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrOsServicos(int index, dynamic value) {
    _trOsServicos.insert(index, value);
    prefs.setStringList(
        'ff_trOsServicos', _trOsServicos.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _trIcones = [];
  List<dynamic> get trIcones => _trIcones;
  set trIcones(List<dynamic> value) {
    _trIcones = value;
    prefs.setStringList(
        'ff_trIcones', value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrIcones(dynamic value) {
    _trIcones.add(value);
    prefs.setStringList(
        'ff_trIcones', _trIcones.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrIcones(dynamic value) {
    _trIcones.remove(value);
    prefs.setStringList(
        'ff_trIcones', _trIcones.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrIcones(int index) {
    _trIcones.removeAt(index);
    prefs.setStringList(
        'ff_trIcones', _trIcones.map((x) => jsonEncode(x)).toList());
  }

  void updateTrIconesAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trIcones[index] = updateFn(_trIcones[index]);
    prefs.setStringList(
        'ff_trIcones', _trIcones.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrIcones(int index, dynamic value) {
    _trIcones.insert(index, value);
    prefs.setStringList(
        'ff_trIcones', _trIcones.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _trTalhoes = [];
  List<dynamic> get trTalhoes => _trTalhoes;
  set trTalhoes(List<dynamic> value) {
    _trTalhoes = value;
    prefs.setStringList(
        'ff_trTalhoes', value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrTalhoes(dynamic value) {
    _trTalhoes.add(value);
    prefs.setStringList(
        'ff_trTalhoes', _trTalhoes.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrTalhoes(dynamic value) {
    _trTalhoes.remove(value);
    prefs.setStringList(
        'ff_trTalhoes', _trTalhoes.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrTalhoes(int index) {
    _trTalhoes.removeAt(index);
    prefs.setStringList(
        'ff_trTalhoes', _trTalhoes.map((x) => jsonEncode(x)).toList());
  }

  void updateTrTalhoesAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trTalhoes[index] = updateFn(_trTalhoes[index]);
    prefs.setStringList(
        'ff_trTalhoes', _trTalhoes.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrTalhoes(int index, dynamic value) {
    _trTalhoes.insert(index, value);
    prefs.setStringList(
        'ff_trTalhoes', _trTalhoes.map((x) => jsonEncode(x)).toList());
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
