import 'package:bonfire/bonfire.dart';
import 'package:codefire/levels/level_02_04.dart';
import 'package:codefire/utilities/languages.dart';
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

class Level0203 extends StatefulWidget {
  const Level0203({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0203> createState() => _Level0203State();
}

class _Level0203State extends State<Level0203> {
  final levelController = LevelController(
    initialCode: '''moveDown(9999);\n''',
    mapJsonPath: 'tiled/level_02_03.json',
    hintTextList: {
      Language.japanese: [
        '私はネクロマンサー、コマンドについてとっても詳しい！',
        '大変だ、コードフィールドを見て！「moveDown(9999);」だなんて…\nこのままだとディノロボくんは下に9999マス進もうとして、壁に激突してしまうよ！',
        'なんてね！実はディノロボくんには衝突防止機能がついてるから、全然平気なんだ♩',
        '壁があってそれ以上進めなくなったら、ぶつかる前にピタッと止まってくれるから安心さ',
        'せっかくだから試してみるといいよ\nとにかく青いスイッチを押せれば扉は開くから大丈夫だよ♩',
      ],
      Language.english: [
        'I am Necrom. I know a lot about commands!',
        'Oh god, look at the code field! "moveDown(9999);"!?\nDino-Robo will try to move down 9999 squares and crash into a wall!',
        'What a surprise! Actually, Dino-Robo is equipped with an anti-collision function, so it is totally safe.',
        'If there\'s a wall and he can\'t go any further, he\'ll stop before he hits it.',
        'Anyway, you can press the play button and the door will open.',
      ],
    },
    playerPosition: Vector2(7, 9),
    roboDinoPosition: Vector2(3, 5),
    minimumStep: 2,
    minimumCommand: 1,
    nextMap: const Level0204(),
  );
  final levelId = 1;
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
