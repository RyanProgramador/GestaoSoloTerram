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
    _safeInit(() {
      _PontosColetados = prefs.getStringList('ff_PontosColetados')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _PontosColetados;
    });
    _safeInit(() {
      _PontosInacessiveis =
          prefs.getStringList('ff_PontosInacessiveis')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _PontosInacessiveis;
    });
    _safeInit(() {
      _trSincroniza = prefs.getStringList('ff_trSincroniza')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _trSincroniza;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_naoLista')) {
        try {
          _naoLista = jsonDecode(prefs.getString('ff_naoLista') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
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

  List<dynamic> _PontosColetados = [];
  List<dynamic> get PontosColetados => _PontosColetados;
  set PontosColetados(List<dynamic> value) {
    _PontosColetados = value;
    prefs.setStringList(
        'ff_PontosColetados', value.map((x) => jsonEncode(x)).toList());
  }

  void addToPontosColetados(dynamic value) {
    _PontosColetados.add(value);
    prefs.setStringList('ff_PontosColetados',
        _PontosColetados.map((x) => jsonEncode(x)).toList());
  }

  void removeFromPontosColetados(dynamic value) {
    _PontosColetados.remove(value);
    prefs.setStringList('ff_PontosColetados',
        _PontosColetados.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromPontosColetados(int index) {
    _PontosColetados.removeAt(index);
    prefs.setStringList('ff_PontosColetados',
        _PontosColetados.map((x) => jsonEncode(x)).toList());
  }

  void updatePontosColetadosAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _PontosColetados[index] = updateFn(_PontosColetados[index]);
    prefs.setStringList('ff_PontosColetados',
        _PontosColetados.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInPontosColetados(int index, dynamic value) {
    _PontosColetados.insert(index, value);
    prefs.setStringList('ff_PontosColetados',
        _PontosColetados.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _PontosInacessiveis = [];
  List<dynamic> get PontosInacessiveis => _PontosInacessiveis;
  set PontosInacessiveis(List<dynamic> value) {
    _PontosInacessiveis = value;
    prefs.setStringList(
        'ff_PontosInacessiveis', value.map((x) => jsonEncode(x)).toList());
  }

  void addToPontosInacessiveis(dynamic value) {
    _PontosInacessiveis.add(value);
    prefs.setStringList('ff_PontosInacessiveis',
        _PontosInacessiveis.map((x) => jsonEncode(x)).toList());
  }

  void removeFromPontosInacessiveis(dynamic value) {
    _PontosInacessiveis.remove(value);
    prefs.setStringList('ff_PontosInacessiveis',
        _PontosInacessiveis.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromPontosInacessiveis(int index) {
    _PontosInacessiveis.removeAt(index);
    prefs.setStringList('ff_PontosInacessiveis',
        _PontosInacessiveis.map((x) => jsonEncode(x)).toList());
  }

  void updatePontosInacessiveisAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _PontosInacessiveis[index] = updateFn(_PontosInacessiveis[index]);
    prefs.setStringList('ff_PontosInacessiveis',
        _PontosInacessiveis.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInPontosInacessiveis(int index, dynamic value) {
    _PontosInacessiveis.insert(index, value);
    prefs.setStringList('ff_PontosInacessiveis',
        _PontosInacessiveis.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _trSincroniza = [jsonDecode('{}')];
  List<dynamic> get trSincroniza => _trSincroniza;
  set trSincroniza(List<dynamic> value) {
    _trSincroniza = value;
    prefs.setStringList(
        'ff_trSincroniza', value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrSincroniza(dynamic value) {
    _trSincroniza.add(value);
    prefs.setStringList(
        'ff_trSincroniza', _trSincroniza.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrSincroniza(dynamic value) {
    _trSincroniza.remove(value);
    prefs.setStringList(
        'ff_trSincroniza', _trSincroniza.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrSincroniza(int index) {
    _trSincroniza.removeAt(index);
    prefs.setStringList(
        'ff_trSincroniza', _trSincroniza.map((x) => jsonEncode(x)).toList());
  }

  void updateTrSincronizaAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trSincroniza[index] = updateFn(_trSincroniza[index]);
    prefs.setStringList(
        'ff_trSincroniza', _trSincroniza.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrSincroniza(int index, dynamic value) {
    _trSincroniza.insert(index, value);
    prefs.setStringList(
        'ff_trSincroniza', _trSincroniza.map((x) => jsonEncode(x)).toList());
  }

  dynamic _naoLista = jsonDecode(
      '{"tipo":"ff_sincroniza_coletas","dados":{"fazenda_id":2,"servico_id":10,"pontos":[{"id":381,"status":1,"obs":"quando ponto inacessível precisa de obs","foto":"quando ponto inacessível precisa de foto","profundidades":[{"id":1,"status":1,"obs":"opcional","foto":"conforme auditoria","data":"2024-02-24 08:00"}]},{"id":382,"status":1,"obs":"","foto":"base64","profundidades":[{"id":1,"status":1,"obs":"","foto":"","data":"2024-02-24 08:00"}]},{"id":383,"status":1,"obs":"","foto":"base64","profundidades":[{"id":1,"status":1,"obs":"","foto":"","data":"2024-02-24 08:00"}]}]}}');
  dynamic get naoLista => _naoLista;
  set naoLista(dynamic value) {
    _naoLista = value;
    prefs.setString('ff_naoLista', jsonEncode(value));
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
