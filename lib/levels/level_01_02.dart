import 'package:bonfire/bonfire.dart';
import 'package:codefire/levels/level_01_03.dart';
import 'package:codefire/levels/level_controller.dart';
import 'package:codefire/levels/level_widget.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/view/common_component/code_fire_field.dart';
import 'package:codefire/view/common_component/code_fire_scaffold.dart';
import 'package:codefire/view/main_screen/main_screen_component.dart';
import 'package:codefire/view/main_screen/main_screen_controller.dart';
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
    initialCode: '''moveUp(2);\n''',
    mapJsonPath: 'tiled/level_01_02.json',
    hintTextList: [
      '私はネクロマンサー、どこにでも現れる',
      'さて、今回は再生ボタンを押すだけでは扉は開かないぞ\nディノロボットがボタンまで辿り着かないからな',
      'コードフィールドに書かれた「moveUp(2);」の文字は、「コマンド」というんだ\nコマンドは、ディノロボットを動かすための呪文のようなものだ',
      'あれを「moveUp(4);」に書き換えてから再生ボタンを押してみなさい',
      'それでうまくいくはずだ\nもし失敗したら、いつでもリセットボタンを押すんだぞ',
    ],
    playerPosition: Vector2(7, 9),
    roboDinoPosition: Vector2(3, 8),
    minimumStep: 4,
    minimumCommand: 1,
    nextMap: const Level0103(),
  );
  final levelId = 0;
  final stageId = 0;

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
      theme: CodeFireField.codeTheme,
      patternMap: CodeFireField.patternMap,
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
              child: LevelWidget(
                focus: focus,
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
