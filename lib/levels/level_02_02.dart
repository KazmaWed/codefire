import 'package:bonfire/bonfire.dart';
import 'package:codefire/levels/level_02_03.dart';
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

class Level0202 extends StatefulWidget {
  const Level0202({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0202> createState() => _Level0202State();
}

class _Level0202State extends State<Level0202> {
  final levelController = LevelController(
    initialCode: '''moveleft(2);\n''',
    mapJsonPath: 'tiled/level_02_02.json',
    hintTextList: [
      '私はネクロマンサー、コマンドについてとっても詳しい！',
      'コードフィールドを見てみて！またコマンドがおかしいと思わない？',
      'コマンドが一文字間違っているだけでも、ディノロボくんは指示を理解できなくなってしまうんだ…',
      'アルファベットの大文字と小文字が違ったり、数字が全角になってるだけでもダメだよ\nコマンドを正しく書くって大変だね！',
      'さあ、コマンドを正しく直せるかな？\nうまくいかない時は、とにかく注意深く見なおしてみてね！',
    ],
    playerPosition: Vector2(7, 9),
    roboDinoPosition: Vector2(4, 6),
    minimumStep: 2,
    minimumCommand: 1,
    nextMap: const Level0203(),
  );
  final levelId = 1;
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
