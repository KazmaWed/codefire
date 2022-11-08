import 'package:bonfire/bonfire.dart';
import 'package:codefire/view/common_component/codefire_components.dart';
import 'package:codefire/view/level_screen/level_controller.dart';
import 'package:codefire/view/level_screen/level_widget.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/view/common_component/codefire_field.dart';
import 'package:codefire/view/top_screen/top_screen.dart';
import 'package:codefire/view/top_screen/top_screen_component.dart';
import 'package:codefire/view/top_screen/top_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:highlight/languages/javascript.dart';

class Level0404 extends StatefulWidget {
  const Level0404({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0404> createState() => _Level0404State();
}

class _Level0404State extends State<Level0404> {
  final levelController = LevelController(
    initialCode: '''

  moveRight(6);
  moveLeft(6);
  moveUp(3);\n''',
    mapJsonPath: 'tiled/level_04_04.json',
    hintTextList: [
      '私はネクロマンサー、実はメガネっ子だよ！',
      '今回はなんだか辺な形をしたステージだね！細い通路の奥にあるスイッチを押していかなきゃいけないよ…',
      'ここでもforループが役に立ちそうだ！下のスイッチから順番に押して上がっていくのが良さそうだね',
      'でもコードフィールドには、まだforループが書かれていないみたいだね…\nforループを追加して、全部のスイッチを押せるようにコマンドを書いてあげて！',
      'forループの書き方なんて覚えてないって？大丈夫だよ！\nコマンドフィールドの右上「FOR」ボタンを押せばforループが自動で追加されるんだ',
      '繰り返すコマンドは波括弧の中に書かなきゃいけなかったね\n他にも直す必要があるところがないか、よく見てみてね^ ^'
    ],
    playerPosition: Vector2(11, 9),
    roboDinoPosition: Vector2(2, 9),
    minimumStep: 36,
    minimumCommand: 4,
    nextMap: const TopScreen(),
  );
  final levelId = 3;
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
