import 'dart:convert';
import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_js/flutter_js.dart';

extension Vector2Extentions on Vector2 {
  String toOctaDirectionStr() {
    final noneZeroX = x == 0 ? 1 / 100000 : x;
    final tangent = -y / noneZeroX;
    final right = x > 0;
    if (right) {
      if (-1 / 8 <= atan(tangent) / pi && atan(tangent) / pi <= 1 / 8) {
        return 'right';
      } else if (1 / 8 < atan(tangent) / pi && atan(tangent) / pi < 3 / 8) {
        return 'upRight';
      } else if (-3 / 8 < atan(tangent) / pi && atan(tangent) / pi < -1 / 8) {
        return 'downRight';
      } else if (3 / 8 <= atan(tangent)) {
        return 'up';
      } else {
        return 'down';
      }
    } else {
      if (-1 / 8 <= atan(tangent) / pi && atan(tangent) / pi <= 1 / 8) {
        return 'left';
      } else if (1 / 8 < atan(tangent) / pi && atan(tangent) / pi < 3 / 8) {
        return 'downLeft';
      } else if (-3 / 8 < atan(tangent) / pi && atan(tangent) / pi < -1 / 8) {
        return 'upLeft';
      } else if (3 / 8 <= atan(tangent)) {
        return 'down';
      } else {
        return 'up';
      }
    }
  }
}

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
}\n
''';
    const footer = '''
\n
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
