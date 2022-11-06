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

class Level0304 extends StatefulWidget {
  const Level0304({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0304> createState() => _Level0304State();
}

class _Level0304State extends State<Level0304> {
  final levelController = LevelController(
    initialCode: '',
    mapJsonPath: 'tiled/level_03_04.json',
    hintTextList: [
      '私はネクロマンサー、人の顔を見るのが苦手だよ！',
      '今度は不思議な形にボタンが並んでいるね…どういう順番で押すのがいいか迷っちゃうね！',
      '順番に関係なく、全てのボタンを押せば扉は開くから、どれが正解というわけではないんだ\nでも、同じ種類のコマンドを使わない方が、クリア後にもらえるスターの数が増えるよ♩',
      '移動するマスの数が増えてもいいから、できるだけ同じコマンドを使わないでクリアすることはできるかな？\nよーく考えてみて！'
    ],
    playerPosition: Vector2(8, 9),
    roboDinoPosition: Vector2(5, 9),
    minimumStep: 12,
    minimumCommand: 3,
    nextMap: const TopScreen(),
  );
  final levelId = 2;
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
