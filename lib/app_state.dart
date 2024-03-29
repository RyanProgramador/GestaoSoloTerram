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
      _login = prefs.getString('ff_login') ?? _login;
    });
    _safeInit(() {
      _senha = prefs.getString('ff_senha') ?? _senha;
    });
    _safeInit(() {
      _UrlApi = prefs.getString('ff_UrlApi') ?? _UrlApi;
    });
    _safeInit(() {
      _validarDistancia =
          prefs.getString('ff_validarDistancia') ?? _validarDistancia;
    });
    _safeInit(() {
      _distanciaMetrosValidacao =
          prefs.getString('ff_distanciaMetrosValidacao') ??
              _distanciaMetrosValidacao;
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
    _safeInit(() {
      _tecnicoid = prefs.getInt('ff_tecnicoid') ?? _tecnicoid;
    });
    _safeInit(() {
      _listaColetasInciadas =
          prefs.getStringList('ff_listaColetasInciadas')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _listaColetasInciadas;
    });
    _safeInit(() {
      _PontosTotalmenteColetados =
          prefs.getStringList('ff_PontosTotalmenteColetados')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _PontosTotalmenteColetados;
    });
    _safeInit(() {
      _dadosTrBuscaPontosLista =
          prefs.getStringList('ff_dadosTrBuscaPontosLista')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _dadosTrBuscaPontosLista;
    });
    _safeInit(() {
      _trTalhoesEmCadaServico =
          prefs.getStringList('ff_trTalhoesEmCadaServico')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _trTalhoesEmCadaServico;
    });
    _safeInit(() {
      _diadoUltimoAcesso = prefs.containsKey('ff_diadoUltimoAcesso')
          ? DateTime.fromMillisecondsSinceEpoch(
              prefs.getInt('ff_diadoUltimoAcesso')!)
          : _diadoUltimoAcesso;
    });
    _safeInit(() {
      _teste = prefs.getStringList('ff_teste') ?? _teste;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _login = '';
  String get login => _login;
  set login(String value) {
    _login = value;
    prefs.setString('ff_login', value);
  }

  String _senha = '';
  String get senha => _senha;
  set senha(String value) {
    _senha = value;
    prefs.setString('ff_senha', value);
  }

  String _UrlApi =
      's://dev.conceittosistemas.com.br/scriptcase/app/GestaoColetas/api/index.php';
  String get UrlApi => _UrlApi;
  set UrlApi(String value) {
    _UrlApi = value;
    prefs.setString('ff_UrlApi', value);
  }

  String _validarDistancia = '';
  String get validarDistancia => _validarDistancia;
  set validarDistancia(String value) {
    _validarDistancia = value;
    prefs.setString('ff_validarDistancia', value);
  }

  String _distanciaMetrosValidacao = '';
  String get distanciaMetrosValidacao => _distanciaMetrosValidacao;
  set distanciaMetrosValidacao(String value) {
    _distanciaMetrosValidacao = value;
    prefs.setString('ff_distanciaMetrosValidacao', value);
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
      '{\"fazenda_id\":2,\"servico_id\":10,\"pontos\":[{\"id\":381,\"status\":1,\"obs\":\"quando ponto inacessível precisa de obs\",\"foto\":\"quando ponto inacessível precisa de foto\",\"profundidades\":[{\"id\":1,\"status\":1,\"obs\":\"opcional\",\"foto\":\"conforme auditoria\",\"data\":\"2024-02-24 08:00\"}]},{\"id\":382,\"status\":1,\"obs\":\"\",\"foto\":\"base64\",\"profundidades\":[{\"id\":1,\"status\":1,\"obs\":\"\",\"foto\":\"\",\"data\":\"2024-02-24 08:00\"}]},{\"id\":383,\"status\":1,\"obs\":\"\",\"foto\":\"base64\",\"profundidades\":[{\"id\":1,\"status\":1,\"obs\":\"\",\"foto\":\"\",\"data\":\"2024-02-24 08:00\"}]}]}');
  dynamic get naoLista => _naoLista;
  set naoLista(dynamic value) {
    _naoLista = value;
    prefs.setString('ff_naoLista', jsonEncode(value));
  }

  int _tecnicoid = 0;
  int get tecnicoid => _tecnicoid;
  set tecnicoid(int value) {
    _tecnicoid = value;
    prefs.setInt('ff_tecnicoid', value);
  }

  List<dynamic> _listaColetasInciadas = [];
  List<dynamic> get listaColetasInciadas => _listaColetasInciadas;
  set listaColetasInciadas(List<dynamic> value) {
    _listaColetasInciadas = value;
    prefs.setStringList(
        'ff_listaColetasInciadas', value.map((x) => jsonEncode(x)).toList());
  }

  void addToListaColetasInciadas(dynamic value) {
    _listaColetasInciadas.add(value);
    prefs.setStringList('ff_listaColetasInciadas',
        _listaColetasInciadas.map((x) => jsonEncode(x)).toList());
  }

  void removeFromListaColetasInciadas(dynamic value) {
    _listaColetasInciadas.remove(value);
    prefs.setStringList('ff_listaColetasInciadas',
        _listaColetasInciadas.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromListaColetasInciadas(int index) {
    _listaColetasInciadas.removeAt(index);
    prefs.setStringList('ff_listaColetasInciadas',
        _listaColetasInciadas.map((x) => jsonEncode(x)).toList());
  }

  void updateListaColetasInciadasAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _listaColetasInciadas[index] = updateFn(_listaColetasInciadas[index]);
    prefs.setStringList('ff_listaColetasInciadas',
        _listaColetasInciadas.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInListaColetasInciadas(int index, dynamic value) {
    _listaColetasInciadas.insert(index, value);
    prefs.setStringList('ff_listaColetasInciadas',
        _listaColetasInciadas.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _PontosTotalmenteColetados = [];
  List<dynamic> get PontosTotalmenteColetados => _PontosTotalmenteColetados;
  set PontosTotalmenteColetados(List<dynamic> value) {
    _PontosTotalmenteColetados = value;
    prefs.setStringList('ff_PontosTotalmenteColetados',
        value.map((x) => jsonEncode(x)).toList());
  }

  void addToPontosTotalmenteColetados(dynamic value) {
    _PontosTotalmenteColetados.add(value);
    prefs.setStringList('ff_PontosTotalmenteColetados',
        _PontosTotalmenteColetados.map((x) => jsonEncode(x)).toList());
  }

  void removeFromPontosTotalmenteColetados(dynamic value) {
    _PontosTotalmenteColetados.remove(value);
    prefs.setStringList('ff_PontosTotalmenteColetados',
        _PontosTotalmenteColetados.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromPontosTotalmenteColetados(int index) {
    _PontosTotalmenteColetados.removeAt(index);
    prefs.setStringList('ff_PontosTotalmenteColetados',
        _PontosTotalmenteColetados.map((x) => jsonEncode(x)).toList());
  }

  void updatePontosTotalmenteColetadosAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _PontosTotalmenteColetados[index] =
        updateFn(_PontosTotalmenteColetados[index]);
    prefs.setStringList('ff_PontosTotalmenteColetados',
        _PontosTotalmenteColetados.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInPontosTotalmenteColetados(int index, dynamic value) {
    _PontosTotalmenteColetados.insert(index, value);
    prefs.setStringList('ff_PontosTotalmenteColetados',
        _PontosTotalmenteColetados.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _dadosTrBuscaPontosLista = [];
  List<dynamic> get dadosTrBuscaPontosLista => _dadosTrBuscaPontosLista;
  set dadosTrBuscaPontosLista(List<dynamic> value) {
    _dadosTrBuscaPontosLista = value;
    prefs.setStringList('ff_dadosTrBuscaPontosLista',
        value.map((x) => jsonEncode(x)).toList());
  }

  void addToDadosTrBuscaPontosLista(dynamic value) {
    _dadosTrBuscaPontosLista.add(value);
    prefs.setStringList('ff_dadosTrBuscaPontosLista',
        _dadosTrBuscaPontosLista.map((x) => jsonEncode(x)).toList());
  }

  void removeFromDadosTrBuscaPontosLista(dynamic value) {
    _dadosTrBuscaPontosLista.remove(value);
    prefs.setStringList('ff_dadosTrBuscaPontosLista',
        _dadosTrBuscaPontosLista.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromDadosTrBuscaPontosLista(int index) {
    _dadosTrBuscaPontosLista.removeAt(index);
    prefs.setStringList('ff_dadosTrBuscaPontosLista',
        _dadosTrBuscaPontosLista.map((x) => jsonEncode(x)).toList());
  }

  void updateDadosTrBuscaPontosListaAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _dadosTrBuscaPontosLista[index] =
        updateFn(_dadosTrBuscaPontosLista[index]);
    prefs.setStringList('ff_dadosTrBuscaPontosLista',
        _dadosTrBuscaPontosLista.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInDadosTrBuscaPontosLista(int index, dynamic value) {
    _dadosTrBuscaPontosLista.insert(index, value);
    prefs.setStringList('ff_dadosTrBuscaPontosLista',
        _dadosTrBuscaPontosLista.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _trTalhoesEmCadaServico = [];
  List<dynamic> get trTalhoesEmCadaServico => _trTalhoesEmCadaServico;
  set trTalhoesEmCadaServico(List<dynamic> value) {
    _trTalhoesEmCadaServico = value;
    prefs.setStringList(
        'ff_trTalhoesEmCadaServico', value.map((x) => jsonEncode(x)).toList());
  }

  void addToTrTalhoesEmCadaServico(dynamic value) {
    _trTalhoesEmCadaServico.add(value);
    prefs.setStringList('ff_trTalhoesEmCadaServico',
        _trTalhoesEmCadaServico.map((x) => jsonEncode(x)).toList());
  }

  void removeFromTrTalhoesEmCadaServico(dynamic value) {
    _trTalhoesEmCadaServico.remove(value);
    prefs.setStringList('ff_trTalhoesEmCadaServico',
        _trTalhoesEmCadaServico.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromTrTalhoesEmCadaServico(int index) {
    _trTalhoesEmCadaServico.removeAt(index);
    prefs.setStringList('ff_trTalhoesEmCadaServico',
        _trTalhoesEmCadaServico.map((x) => jsonEncode(x)).toList());
  }

  void updateTrTalhoesEmCadaServicoAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _trTalhoesEmCadaServico[index] = updateFn(_trTalhoesEmCadaServico[index]);
    prefs.setStringList('ff_trTalhoesEmCadaServico',
        _trTalhoesEmCadaServico.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInTrTalhoesEmCadaServico(int index, dynamic value) {
    _trTalhoesEmCadaServico.insert(index, value);
    prefs.setStringList('ff_trTalhoesEmCadaServico',
        _trTalhoesEmCadaServico.map((x) => jsonEncode(x)).toList());
  }

  DateTime? _diadoUltimoAcesso;
  DateTime? get diadoUltimoAcesso => _diadoUltimoAcesso;
  set diadoUltimoAcesso(DateTime? value) {
    _diadoUltimoAcesso = value;
    value != null
        ? prefs.setInt('ff_diadoUltimoAcesso', value.millisecondsSinceEpoch)
        : prefs.remove('ff_diadoUltimoAcesso');
  }

  List<String> _teste = [
    '1',
    '2',
    '3',
    '4',
    '5',
    'Hello World',
    '5',
    '6',
    '7',
    '8'
  ];
  List<String> get teste => _teste;
  set teste(List<String> value) {
    _teste = value;
    prefs.setStringList('ff_teste', value);
  }

  void addToTeste(String value) {
    _teste.add(value);
    prefs.setStringList('ff_teste', _teste);
  }

  void removeFromTeste(String value) {
    _teste.remove(value);
    prefs.setStringList('ff_teste', _teste);
  }

  void removeAtIndexFromTeste(int index) {
    _teste.removeAt(index);
    prefs.setStringList('ff_teste', _teste);
  }

  void updateTesteAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    _teste[index] = updateFn(_teste[index]);
    prefs.setStringList('ff_teste', _teste);
  }

  void insertAtIndexInTeste(int index, String value) {
    _teste.insert(index, value);
    prefs.setStringList('ff_teste', _teste);
  }

  String _numeroVolumeQrCode = '';
  String get numeroVolumeQrCode => _numeroVolumeQrCode;
  set numeroVolumeQrCode(String value) {
    _numeroVolumeQrCode = value;
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
