import 'package:bonfire/bonfire.dart';
import 'package:codefire/levels/level_03_04.dart';
import 'package:codefire/view/common_component/codefire_components.dart';
import 'package:codefire/view/common_component/level_controller.dart';
import 'package:codefire/view/common_component/level_widget.dart';
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
    showCollisionArea: false,
    initialCode: '''move2Up;\n''',
    mapJsonPath: 'tiled/level_03_03.json',
    hintTextList: [
      '私はネクロマンサー、コマンドについてとっても詳しい！',
      'ねえ、コードフィールドを見てみて！なにかおかしいと思わない？',
      'コマンドは必ず「moveUp(2)」みたいな形じゃないとダメなんだ\n「Up」は方向を、括弧の中の数字は進むマスの数を表しているよ',
      'コマンドを正しく直して、ディノロボくんがボタンを押せる様にしてあげられるかな？',
      'もちろん、コードフィールド上の矢印ボタンを使ってもいいよ♩'
    ],
    playerPosition: Vector2(7, 9),
    roboDinoPosition: Vector2(3, 7),
    minimumStep: 2,
    minimumCommand: 1,
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
