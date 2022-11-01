import 'package:bonfire/bonfire.dart';
import 'package:codefire/maps/dungeon_02/dungeon_02.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/view/common_component/code_fire_field.dart';
import 'package:codefire/view/common_component/code_fire_scaffold.dart';
import 'package:codefire/view/main_screen/main_screen_component.dart';
import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
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
              callback: (result) {
                final controller = BonfireInjector().get<NpcRoboDinoController>();
                controller.commandInput(result);
              },
            ),
          ),
          const VerticalDivider(width: 0),
          Expanded(flex: 2, child: Dungeon02(focus: focus)),
        ],
      ),
    );
  }
}
