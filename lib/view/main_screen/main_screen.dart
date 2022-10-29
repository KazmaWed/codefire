import 'package:codefire/view/main_screen/extentions.dart';
import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/themes/arduino-light.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:flutter_highlight/themes/solarized-light.dart';
// ignore: depend_on_referenced_packages
import 'package:highlight/languages/javascript.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static String initialValue = '''
moveDown(1);
for (let idx = 0; idx < 3; idx++) {
  if(idx % 2 == 0) {
    moveLeft(2);
  } else {
    moveRight(2);
  }
  moveUp(4);
}''';
  // static const codeTheme = atomOneLightTheme;
  static const codeTheme = arduinoLightTheme;

  static const colorThemeName = 'code';
  final controller = CodeController(
    text: initialValue,
    language: javascript,
    theme: codeTheme,
    patternMap: {
      'moveUp': TextStyle(color: codeTheme[colorThemeName]!.color),
      'moveDown': TextStyle(color: codeTheme[colorThemeName]!.color),
      'moveLeft': TextStyle(color: codeTheme[colorThemeName]!.color),
      'moveRight': TextStyle(color: codeTheme[colorThemeName]!.color),
    },
    onChange: (value) {},
  );
  final style = const TextStyle(fontSize: 21);

  String _result = '';

  @override
  Widget build(BuildContext context) {
    final codeField = CodeField(
      controller: controller,
      expands: true,
      textStyle: style,
    );

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    _result == '' ? 'no output...' : _result,
                    style: style,
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(child: codeField),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          child: Text(
                            'EXECUTE',
                            style: style,
                          ),
                          onPressed: () async {
                            String code = controller.text;
                            try {
                              setState(() {
                                _result = code.toPlayerCommand();
                              });
                            } catch (error) {
                              setState(() {
                                _result = error.toString();
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
