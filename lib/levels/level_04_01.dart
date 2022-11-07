import 'package:bonfire/bonfire.dart';
import 'package:codefire/levels/level_04_02.dart';
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

class Level0401 extends StatefulWidget {
  const Level0401({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0401> createState() => _Level0401State();
}

class _Level0401State extends State<Level0401> {
  final levelController = LevelController(
    initialCode: '''
for (idx = 1; idx <= 2; idx++) {
  moveLeft(3);
  moveUp(3);
}\n''',
    mapJsonPath: 'tiled/level_04_01.json',
    hintTextList: [
      '私はネクロマンサー、実はメガネっ子だよ！',
      '今回のステージは、青いスイッチが対角線上にならんでいるね…\nディノロボくんは斜めには進めないから、一直線に進んで全部のスイッチを押すことはできないよ',
      '左、上、左、上の順番で進みたいけど、同じコマンドを使うとクリア後のスターがもらえないね…\nこんな時は「forループ」を使うといいよ！読み方はフォーループだよ',
      'forループの書き方は少し難しいけど、コードフィールドの1行目「 for() { 」から最後の「 } 」までがforループだよ',
      '２行目と３行目の「 { } 」の間に書いてある部分は、すでに使ったことのあるコマンドだね',
      'forループは、波括弧の間に書かれたコマンドをくり返し実行してくれるんだ！\nだから同じコマンドを何度も書かなくていいんだ！とっても便利だね♩',
      '再生ボタンを押すだけで、ディノロボくんが２つのスイッチを順番に押してくれるはずだから試してみて^ ^',
    ],
    playerPosition: Vector2(11, 9),
    roboDinoPosition: Vector2(8, 9),
    minimumStep: 12,
    minimumCommand: 3,
    nextMap: const Level0402(),
  );
  final levelId = 3;
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
