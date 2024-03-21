// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class LoadingCircle extends StatefulWidget {
  const LoadingCircle({
    Key? key,
    this.width,
    this.height,
    this.color,
    this.circleRadius,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double? circleRadius;
  final Color? color;

  @override
  _LoadingCircleState createState() => _LoadingCircleState();
}

class _LoadingCircleState extends State<LoadingCircle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Center(
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: CircularProgressIndicator(
            strokeWidth: 5.0,
            valueColor:
                AlwaysStoppedAnimation<Color>(widget.color ?? Colors.blue),
          ),
        ),
      ),
    );
  }
}
