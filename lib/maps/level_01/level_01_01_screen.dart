import 'package:bonfire/bonfire.dart';
import 'package:codefire/maps/level_01/level_01_02_screen.dart';
import 'package:codefire/maps/level_controller.dart';
import 'package:codefire/maps/level_widget.dart';
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

class Level0101Screen extends StatefulWidget {
  const Level0101Screen({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0101Screen> createState() => _Level0101ScreenState();
}

class _Level0101ScreenState extends State<Level0101Screen> {
  final levelController = LevelController(
    showCollisionArea: false,
    initialCode: '''moveLeft(2);\n''',
    mapJsonPath: 'tiled/level_01_01.json',
    hintTextList: [
      '私はネクロマンサー、この世界のルールを知っている',
      'さて、画面左側に白い枠が見えるだろう、あれは「コードフィールド」だ',
      'コードフィールドの右下に「再生ボタン」が見えるだろう\nまずはそれを押してみなさい',
      '左の部屋のディノロボットがボタンを押して、扉が開かれるはずだ',
      'うまく行かないときはリセットボタンを押してみなさい\n再生ボタンのちょうど左側にある',
    ],
    playerPosition: Vector2(7, 9),
    roboDinoPosition: Vector2(4, 6),
    minimumStep: 2,
    minimumCommand: 1,
    nextMap: const Level0102Screen(),
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
