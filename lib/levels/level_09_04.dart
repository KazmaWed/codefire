import 'package:bonfire/bonfire.dart';
import 'package:codefire/utilities/languages.dart';
import 'package:codefire/view/common_component/codefire_components.dart';
import 'package:codefire/view/level_screen/level_widget.dart';
import 'package:codefire/view/level_screen/level_controller.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/view/common_component/codefire_field.dart';
import 'package:codefire/view/top_screen/top_screen_component.dart';
import 'package:codefire/view/top_screen/top_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:highlight/languages/javascript.dart';

class Level0904 extends StatefulWidget {
  const Level0904({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0904> createState() => _Level0904State();
}

class _Level0904State extends State<Level0904> {
  final levelController = LevelController(
    initialCode: '''
moveLeft(8);
for (let idx = 1; idx <= 2; idx++) {
  moveUp(3 * idx - 1);
  moveRight(5);
}
moveDown(1)''',
    mapJsonPath: 'tiled/level_09_04.json',
    hintTextList: {
      Language.japanese: [
        '私はネクロマンサー、自己紹介が好き',
      ],
    },
    playerPosition: Vector2(11, 9),
    roboDinoPosition: Vector2(9, 9),
    minimumStep: 22,
    minimumCommand: 5,
    nextMap: const Level0904(),
  );
  final levelId = 8;
  final stageId = 3;

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
        final mainScreenController = ref.watch(topScreenControllerProvider);
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
