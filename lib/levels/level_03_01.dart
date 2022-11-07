import 'package:bonfire/bonfire.dart';
import 'package:codefire/levels/level_03_02.dart';
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

class Level0301 extends StatefulWidget {
  const Level0301({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0301> createState() => _Level0301State();
}

class _Level0301State extends State<Level0301> {
  final levelController = LevelController(
    initialCode: '''moveLeft(3);\n''',
    mapJsonPath: 'tiled/level_03_01.json',
    hintTextList: [
      '私はネクロマンサー、人の顔を見るのが苦手だよ！',
      '左の部屋を見てごらん、青いスイッチがたくさん並んでいるね\nこの部屋の扉を開くには全てのスイッチを押す必要があるよ',
      'ディノロボくんはスイッチを押しながら、上を突っ切って歩くことができるから\n今回は左に進むだけでうまく行くはずだ',
      'ほら、試した見て！'
    ],
    playerPosition: Vector2(8, 9),
    roboDinoPosition: Vector2(5, 6),
    minimumStep: 3,
    minimumCommand: 1,
    nextMap: const Level0302(),
  );
  final levelId = 2;
  final stageId = 0;

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
