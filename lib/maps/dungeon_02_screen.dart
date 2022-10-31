import 'package:bonfire/bonfire.dart';
import 'package:codefire/maps/dungeon_02.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/view/common_component/code_fire_field.dart';
import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/themes/arduino-light.dart';
// import 'package:flutter_highlight/themes/atom-one-light.dart';
// ignore: depend_on_referenced_packages
import 'package:highlight/languages/javascript.dart';

class Dungeon02Screen extends StatefulWidget {
  const Dungeon02Screen({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Dungeon02Screen> createState() => _Dungeon02ScreenState();
}

class _Dungeon02ScreenState extends State<Dungeon02Screen> {
  @override
  Widget build(BuildContext context) {
    String defaultCode = widget.initialCode ??
        '''
for (let idx = 0; idx < 2; idx++) {
  moveLeft(7);
  moveUp(10);
  moveRight(9);
  moveDown(7)
}''';

    // static const codeTheme = atomOneLightTheme;
    const codeTheme = arduinoLightTheme;
    const colorThemeName = 'code';
    final controller = CodeController(
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: CodeFireField(
              controller: controller,
              parentWidget: widget,
              callback: (result) {
                final controller = BonfireInjector().get<NpcRoboDinoController>();
                controller.commandInput(result);
              },
            ),
          ),
          const VerticalDivider(width: 0),
          const Expanded(
            flex: 3,
            child: Dungeon02(),
          ),
        ],
      ),
    );
  }
}
