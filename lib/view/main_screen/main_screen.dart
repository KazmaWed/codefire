import 'package:bonfire/bonfire.dart';
import 'package:codefire/maps/dungeon_01.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/view/common_component/code_fire_field.dart';
import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/themes/arduino-light.dart';
// import 'package:flutter_highlight/themes/atom-one-light.dart';
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
      'moveUp': TextStyle(color: codeTheme[colorThemeName]?.color),
      'moveDown': TextStyle(color: codeTheme[colorThemeName]?.color),
      'moveLeft': TextStyle(color: codeTheme[colorThemeName]?.color),
      'moveRight': TextStyle(color: codeTheme[colorThemeName]?.color),
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            child: CodeFireField(
              controller: controller,
              callback: (result) {
                final controller = BonfireInjector().get<NpcRoboDinoController>();
                controller.commandInput(result);
              },
            ),
          ),
          const VerticalDivider(width: 0),
          Expanded(child: Dungeon01(
            commandInput: (value) {
              value = controller.text;
            },
          )),
        ],
      ),
    );
  }
}
