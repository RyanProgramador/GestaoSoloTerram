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

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modest_pagination/modest_pagination.dart';

class ListPaginacaoWidget extends StatefulWidget {
  const ListPaginacaoWidget({
    super.key,
    this.width,
    this.height,
    this.trPontos,
  });

  final double? width;
  final double? height;
  final List<dynamic>? trPontos;

  @override
  State<ListPaginacaoWidget> createState() => _ListPaginacaoWidgetState();
}

class _ListPaginacaoWidgetState extends State<ListPaginacaoWidget> {
  @override
  Widget build(BuildContext context) {
    return ModestPagination(
      items: widget.trPontos ?? [],
      itemsPerPage: 3, // Quantidade de itens por página
      activeTextColor: Colors.white,
      inactiveTextColor: Colors.white70,
      pagesControllerIconsColor: Colors.white,
      sheetsControllerIconsColor: Colors.white,
      useListView: true, // Use GridView setting this to false
      childWidget: (dynamic element) {
        // Aqui você constrói o layout para cada elemento da lista
        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
          child: Container(
            width: double.infinity,
            height: 190.0, // Altura do container, ajuste conforme necessário
            child: Center(
              child:
                  Text(element.toString()), // Exibição simplificada do elemento
            ),
          ),
        );
      },
    );
  }
}
