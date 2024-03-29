// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';

import 'package:crypto/crypto.dart';

Future<String> md5encode(String? senha) async {
  // create a md5 md5encode that returns the String i give, but in md5 encoded

  final bytes = utf8.encode(senha!);
  final digest = md5.convert(bytes);

  return digest.toString();
}
