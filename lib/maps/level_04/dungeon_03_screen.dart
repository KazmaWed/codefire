import 'package:bonfire/bonfire.dart';
import 'package:codefire/maps/level_04/dungeon_03.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/view/common_component/code_fire_field.dart';
import 'package:codefire/view/common_component/code_fire_scaffold.dart';
import 'package:codefire/view/main_screen/main_screen_component.dart';
import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
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

    final controller = CodeController(
      text: defaultCode,
      language: javascript,
      theme: CodeFireField.codeTheme,
      patternMap: CodeFireField.patternMap,
    );
    final focus = FocusNode();
    return CodefireScaffold(
      floatingActinButton: const GoBackFloatingButton(),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: CodeFireField(
              controller: controller,
              parentWidget: widget,
              gameScreenFocus: focus,
              onPlay: (commandList) {
                final controller = BonfireInjector().get<NpcRoboDinoController>();
                controller.commandInput(commandList);
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
