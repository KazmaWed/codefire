import 'package:bonfire/bonfire.dart';
import 'package:codefire/maps/level_01/level_01_04.dart';
import 'package:codefire/maps/level_01/level_01_04_controller.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/view/common_component/code_fire_field.dart';
import 'package:codefire/view/common_component/code_fire_scaffold.dart';
import 'package:codefire/view/main_screen/main_screen_component.dart';
import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
// ignore: depend_on_referenced_packages
import 'package:highlight/languages/javascript.dart';

class Level0104Screen extends StatefulWidget {
  const Level0104Screen({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0104Screen> createState() => _Level0104ScreenState();
}

class _Level0104ScreenState extends State<Level0104Screen> {
  @override
  Widget build(BuildContext context) {
    String defaultCode = widget.initialCode ?? Level0104Controller.initialCode;

    final codeController = CodeController(
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
          Expanded(flex: 2, child: Level0104(focus: focus)),
        ],
      ),
    );
  }
}
