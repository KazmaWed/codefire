import 'package:bonfire/bonfire.dart';
import 'package:codefire/maps/dungeon_03/dungeon_03.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/view/common_component/code_fire_field.dart';
import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/themes/arduino-light.dart';
// import 'package:flutter_highlight/themes/atom-one-light.dart';
// ignore: depend_on_referenced_packages
import 'package:highlight/languages/javascript.dart';

class Dungeon03Screen extends StatefulWidget {
  const Dungeon03Screen({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Dungeon03Screen> createState() => _Dungeon03ScreenState();
}

class _Dungeon03ScreenState extends State<Dungeon03Screen> {
  @override
  Widget build(BuildContext context) {
    String defaultCode = widget.initialCode ??
        '''
for (let idx = 1; idx <= 2; idx++) {
  moveLeft(10);
  moveUp(6);
  moveRight(6);
}''';

    // const codeTheme = atomOneLightTheme;
    // const colorThemeName = 'name';
    const codeTheme = arduinoLightTheme;
    const colorThemeName = 'code';
    final codeController = CodeController(
      text: defaultCode,
      language: javascript,
      theme: codeTheme,
      patternMap: {
        'moveUp': TextStyle(color: codeTheme[colorThemeName]?.color),
        'moveDown': TextStyle(color: codeTheme[colorThemeName]?.color),
        'moveLeft': TextStyle(color: codeTheme[colorThemeName]?.color),
        'moveRight': TextStyle(color: codeTheme[colorThemeName]?.color),
      },
    );
    final focus = FocusNode();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: CodeFireField(
              controller: codeController,
              parentWidget: widget,
              gameScreenFocus: focus,
              callback: (result) {
                final controller = BonfireInjector().get<NpcRoboDinoController>();
                controller.commandInput(result);
              },
            ),
          ),
          const VerticalDivider(width: 0),
          Expanded(flex: 2, child: Dungeon03(focus: focus)),
        ],
      ),
    );
  }
}
