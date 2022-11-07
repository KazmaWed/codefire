import 'package:bonfire/bonfire.dart';
import 'package:codefire/levels/level_03_03.dart';
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

class Level0302 extends StatefulWidget {
  const Level0302({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0302> createState() => _Level0302State();
}

class _Level0302State extends State<Level0302> {
  final levelController = LevelController(
    initialCode: '''
moveUp(4);
moveLeft(3);
''',
    mapJsonPath: 'tiled/level_03_02.json',
    hintTextList: [
      '私はネクロマンサー、人の顔を見るのが苦手だよ！',
      '左の部屋をみて、今度はスイッチが離れたところにあって一度に全てのスイッチを押すことはできなさそうだね…',
      'こんな時は、コマンドをいくつか繋げて見よう！\nディノロボくんは上から順番にコマンドの指示にしたがって動いてくれるよ♩',
      '今回は上に進んで右のスイッチを押してから、次に左に進む、という風にすればうまくいきそうだ！',
      'コマンドとコマンドの間にセミコロン(;)を打つか、改行を入れること忘れないでね！\nセミコロンや改行を忘れただけで、ディノロボくんがコマンドを理解できなくなることがあるんだ…',
    ],
    playerPosition: Vector2(8, 9),
    roboDinoPosition: Vector2(5, 8),
    minimumStep: 7,
    minimumCommand: 2,
    nextMap: const Level0303(),
  );
  final levelId = 2;
  final stageId = 1;

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
