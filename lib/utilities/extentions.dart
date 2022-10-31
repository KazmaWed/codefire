import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_js/flutter_js.dart';

extension BuildContextExtensions on BuildContext {
  Future goTo(Widget widget) {
    return Navigator.pushAndRemoveUntil(
      this,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Container(
            color: Colors.black,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
      (Route<dynamic> route) => false,
    );
  }
}

extension StringExtention on String {
  String runAsJS() {
    final JavascriptRuntime javascriptRuntime = getJavascriptRuntime();
    String jsResult = javascriptRuntime.evaluate(this).stringResult;
    return jsResult;
  }

  String toPlayerCommandStr() {
    const header = '''
var playerCommandOutput = [];

function moveUp(d = 1) {
  const newCommand = {
    direction: 'up',
    count: d
  };
  playerCommandOutput.push(newCommand);
}

function moveDown(d = 1) {
  const newCommand = {
    direction: 'down',
    count: d
  };
  playerCommandOutput.push(newCommand);
}

function moveLeft(d = 1) {
  const newCommand = {
    direction: 'left',
    count: d
  };
  playerCommandOutput.push(newCommand);
}

function moveRight(d = 1) {
  const newCommand = {
    direction: 'right',
    count: d
  };
  playerCommandOutput.push(newCommand);
}
''';
    const footer = '''
const json = {data: playerCommandOutput};
JSON.stringify(playerCommandOutput)
''';

    try {
      return (header + this + footer).runAsJS();
    } catch (e) {
      return e.toString();
    }
  }

  List<Map<String, dynamic>> toPlayerCommandMap() {
    List<dynamic> jsonDecoded = json.decode(toPlayerCommandStr());

    List<Map<String, dynamic>> casted = jsonDecoded.map((entity) {
      final String direction = entity['direction'];
      final int count = entity['count'];
      return {'direction': direction, 'count': count};
    }).toList();

    return casted;
  }
}
