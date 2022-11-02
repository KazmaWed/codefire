import 'package:bonfire/bonfire.dart';
import 'package:codefire/maps/level_01/level_01_01.dart';
import 'package:codefire/maps/level_01/level_01_01_controller.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/view/common_component/code_fire_field.dart';
import 'package:codefire/view/common_component/code_fire_scaffold.dart';
import 'package:codefire/view/main_screen/main_screen_component.dart';
import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
// ignore: depend_on_referenced_packages
import 'package:highlight/languages/javascript.dart';

class Level0101Screen extends StatefulWidget {
  const Level0101Screen({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0101Screen> createState() => _Level0101ScreenState();
}

class _Level0101ScreenState extends State<Level0101Screen> {
  @override
  Widget build(BuildContext context) {
    String defaultCode = widget.initialCode ?? Level0101Controller.initialCode;

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
          Expanded(flex: 2, child: Level0101(focus: focus)),
        ],
      ),
    );
  }
}
