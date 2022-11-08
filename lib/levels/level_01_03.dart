import 'package:bonfire/bonfire.dart';
import 'package:codefire/levels/level_01_04.dart';
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

class Level0103 extends StatefulWidget {
  const Level0103({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0103> createState() => _Level0103State();
}

class _Level0103State extends State<Level0103> {
  final levelController = LevelController(
    initialCode: '''moveUp(4);\n''',
    mapJsonPath: 'tiled/level_01_03.json',
    hintTextList: [
      '私はネクロマンサー、この世界のルールを知ってるよ！',
      '今回のコマンド「moveUp();」は「上に進んで」という指示なんだ\n括弧の中の数字「4」は進むマスの数を表しているよ',
      '再生ボタンを押せば、ディノロボットが「上に4マス」進んで、スイッチを押してくれるはず♩',
      'さあ、実際に試してみて！\n巻き戻しボタンは何度でも押せるからね',
    ],
    playerPosition: Vector2(7, 9),
    roboDinoPosition: Vector2(3, 8),
    minimumStep: 6,
    minimumCommand: 2,
    nextMap: const Level0104(),
  );
  final levelId = 0;
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
