// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<bool> lembrarSenha(
  DateTime? diaAtual,
  DateTime? diaDoUltimoAcesso,
) async {
  if (diaAtual != null && diaDoUltimoAcesso != null) {
    Duration diff = diaAtual.difference(diaDoUltimoAcesso);
    if (diff.inDays < 30) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}
