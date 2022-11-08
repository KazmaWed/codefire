import 'package:bonfire/bonfire.dart';
import 'package:codefire/levels/level_01_02.dart';
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

class Level0101 extends StatefulWidget {
  const Level0101({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0101> createState() => _Level0101State();
}

class _Level0101State extends State<Level0101> {
  final levelController = LevelController(
    initialCode: '''moveLeft(2);\n''',
    mapJsonPath: 'tiled/level_01_01.json',
    hintTextList: [
      '私はネクロマンサー、この世界のルールを知ってるよ！',
      'ほら、画面左側に白い枠が見えるでしょ、あれは「コードフィールド」',
      'コードフィールドの右下に「再生ボタン」があるでしょ？\nまずはそれを押してみて',
      '左の部屋の「ディノロボくん」が青いスイッチを押して、扉が開かれるはず♩',
      'うまく行かないときは「巻き戻しボタン」を押してみて\n再生ボタンのちょうど左側にあるのがそれだよ！'
    ],
    playerPosition: Vector2(7, 9),
    roboDinoPosition: Vector2(4, 6),
    minimumStep: 2,
    minimumCommand: 1,
    nextMap: const Level0102(),
  );
  final levelId = 0;
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
