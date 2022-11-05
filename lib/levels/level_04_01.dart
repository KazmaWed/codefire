import 'package:bonfire/bonfire.dart';
import 'package:codefire/levels/level_widget.dart';
import 'package:codefire/levels/level_controller.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/view/common_component/codefire_field.dart';
import 'package:codefire/view/common_component/codefire_scaffold.dart';
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
    showCollisionArea: false,
    initialCode: '''moveLeft(10);\n''',
    mapJsonPath: 'tiled/level_04_01.json',
    hintTextList: [
      '私はネクロマンサー、自己紹介が好き',
      'さて、今回も再生ボタンを押すだけでは扉は開かないぞ\n上に進んでから、そのあと左に進むようにコマンドを送らなければダメだ',
      '「moveUp(4);」の次の行に「moveLeft(2);」と入力してみるといい\n入力が面倒臭い場合は、コードフィールド上の「←」ボタンを押してみるといいだろう',
      'ふむ、だいぶ分かってきたぞ、という顔をしているな…\nさあ、その手で試してみるんだ',
    ],
    playerPosition: Vector2(13, 9),
    roboDinoPosition: Vector2(11, 9),
    minimumStep: 23,
    minimumCommand: 5,
    nextMap: const Level0401(),
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
