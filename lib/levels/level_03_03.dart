import 'package:bonfire/bonfire.dart';
import 'package:codefire/levels/level_03_04.dart';
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

class Level0303 extends StatefulWidget {
  const Level0303({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0303> createState() => _Level0303State();
}

class _Level0303State extends State<Level0303> {
  final levelController = LevelController(
    initialCode: '''
moveUp(4);
moveLeft(3);
moveDown(4);
''',
    mapJsonPath: 'tiled/level_03_03.json',
    hintTextList: [
      '私はネクロマンサー、人の顔を見るのが苦手だよ！',
      '今度はスイッチが３つあるけど、全てを１度に押すことはできなそうだね\nコマンドも３つ使う必要がありそうだ',
      '既にコードフィールドにコマンドが書かれているから、扉を開くだけなら再生ボタンを押すだけで十分だ！\nでも、他にもっといい方法はないかな？',
      '使ったコマンドの数が同じなら、ディノロボくんが動いたマスの数が少ない方が、クリア後にもらえるスターの数は増えるよ',
      'クリアした後にもっといい方法が思い浮かんだら、巻き戻しボタンを押して何度でもやり直せるから、いっぱい試してみて♩',
    ],
    playerPosition: Vector2(8, 9),
    roboDinoPosition: Vector2(5, 8),
    minimumStep: 10,
    minimumCommand: 3,
    nextMap: const Level0304(),
  );
  final levelId = 2;
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
