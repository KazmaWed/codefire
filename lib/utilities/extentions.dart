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
  String evalJS() {
    final JavascriptRuntime javascriptRuntime = getJavascriptRuntime();
    String jsResult = javascriptRuntime.evaluate(this).stringResult;
    return jsResult;
  }

  List<String> toPlayerCommand() {
    const header = '''
var playerCommandOutput = [];

function moveUp(d = 1) {
  for(let idx = 0; idx < d; idx++) {
    playerCommandOutput.push('up');
  }
}

function moveDown(d = 1) {
  for(let idx = 0; idx < d; idx++) {
    playerCommandOutput.push('down');
  }
}

function moveLeft(d = 1) {
  for(let idx = 0; idx < d; idx++) {
    playerCommandOutput.push('left');
  }
}

function moveRight(d = 1) {
  for(let idx = 0; idx < d; idx++) {
    playerCommandOutput.push('right');
  }
}
''';
    const footer = 'playerCommandOutput';

    try {
      return (header + this + footer).evalJS().split(',');
    } catch (e) {
      return [e.toString()];
    }
  }
}
