import 'package:bonfire/bonfire.dart';
import 'package:codefire/levels/level_04_04.dart';
import 'package:codefire/view/common_component/codefire_components.dart';
import 'package:codefire/view/level_screen/level_controller.dart';
import 'package:codefire/view/level_screen/level_widget.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/view/common_component/codefire_field.dart';
import 'package:codefire/view/top_screen/top_screen_component.dart';
import 'package:codefire/view/top_screen/top_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:highlight/languages/javascript.dart';

class Level0403 extends StatefulWidget {
  const Level0403({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0403> createState() => _Level0403State();
}

class _Level0403State extends State<Level0403> {
  final levelController = LevelController(
    initialCode: '''
for (idx = 1; idx <= 2; idx++) {
  moveLeft(3);
  moveUp(2);
}
moveDown(6)\n''',
    mapJsonPath: 'tiled/level_04_03.json',
    hintTextList: [
      '私はネクロマンサー、人の顔を見るのが苦手だよ！',
    ],
    playerPosition: Vector2(11, 9),
    roboDinoPosition: Vector2(8, 7),
    minimumStep: 16,
    minimumCommand: 4,
    nextMap: const Level0404(),
  );
  final levelId = 3;
  final stageId = 2;

  @override
  Widget build(BuildContext context) {
    String defaultCode = widget.initialCode ?? levelController.initialCode;
    levelController.init();

    final codeController = CodeController(
      text: defaultCode,
      language: javascript,
      theme: CodefireField.codeTheme,
      patternMap: CodefireField.patternMap,
    );

    final focus = FocusNode();

    return Consumer(builder: (context, ref, child) {
      void onClear() {
        final mainScreenController = ref.watch(mainScreenControllerProvider);
        final result = levelController.culcScore(context, codeController.text);
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
              child: CodefireField(
                codeController: codeController,
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
              child: LevelWidget(
                // focus: focus,
                levelController: levelController,
                onClear: () => onClear(),
              ),
            ),
          ],
        ),
      );
    });
  }
}
