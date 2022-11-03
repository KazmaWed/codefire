import 'package:bonfire/bonfire.dart';
import 'package:codefire/maps/level_04/level_04_01.dart';
import 'package:codefire/maps/level_controller.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/view/common_component/code_fire_field.dart';
import 'package:codefire/view/common_component/code_fire_scaffold.dart';
import 'package:codefire/view/main_screen/main_screen.dart';
import 'package:codefire/view/main_screen/main_screen_component.dart';
import 'package:codefire/view/main_screen/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:highlight/languages/javascript.dart';

class Level0104Screen extends StatefulWidget {
  const Level0104Screen({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0104Screen> createState() => _Level0104ScreenState();
}

class _Level0104ScreenState extends State<Level0104Screen> {
  final levelController = LevelController(
    initialCode: '',
    mapJsonPath: 'tiled/level_01_04.json',
    // hintTextList: [],
    playerPosition: Vector2(7, 9),
    roboDinoPosition: Vector2(2, 8),
    minimumStep: 8,
    minimumCommand: 3,
    nextMap: const CodefireMainScreen(),
  );
  final levelId = 0;
  final stageId = 3;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      levelController.init();
      String defaultCode = widget.initialCode ?? levelController.initialCode;

      final codeController = CodeController(
        text: defaultCode,
        language: javascript,
        theme: CodeFireField.codeTheme,
        patternMap: CodeFireField.patternMap,
      );
      final focus = FocusNode();

      void onClear() {
        final mainScreenController = ref.watch(mainScreenControllerProvider);
        final result = levelController.culcScore(codeController.text);
        if (mainScreenController.levels[levelId]['maps'][stageId]['star'] < result['star']) {
          mainScreenController.levels[levelId]['maps'][stageId]['star'] = result['star'];
        }
      }

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
                onPlay: (commandList) {
                  final controller = BonfireInjector().get<NpcRoboDinoController>();
                  controller.commandInput(commandList);
                },
              ),
            ),
            const VerticalDivider(width: 0),
            Expanded(
              flex: 2,
              child: Level0401(
                focus: focus,
                levelController: levelController,
                onClear: () {
                  onClear();
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
