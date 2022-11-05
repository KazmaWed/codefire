import 'package:bonfire/bonfire.dart';
import 'package:codefire/levels/level_01_03.dart';
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

class Level0102 extends StatefulWidget {
  const Level0102({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0102> createState() => _Level0102State();
}

class _Level0102State extends State<Level0102> {
  final levelController = LevelController(
    showCollisionArea: false,
    initialCode: '''moveRight(2);\n''',
    mapJsonPath: 'tiled/level_01_02.json',
    hintTextList: [
      '私はネクロマンサー、この世界のルールを知ってるよ！',
      'コードフィールドに書かれた「moveRight();」の文字は「コマンド」というんだ\n左の部屋にいるディノロボくんは、そのコマンド通りに動くよ',
      '「moveRight();」のコマンドはディノロボくんに「右に動いて」と指示しているんだ',
      'さて、今回も再生ボタンを押すだけで扉が開くはずだよ♩',
      'もし失敗したら、いつでも巻き戻しボタンを押すんだよ！',
    ],
    playerPosition: Vector2(7, 9),
    roboDinoPosition: Vector2(2, 6),
    minimumStep: 4,
    minimumCommand: 1,
    nextMap: const Level0103(),
  );
  final levelId = 0;
  final stageId = 1;

  @override
  void dispose() {
    super.dispose();
    levelController.init();
  }

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
