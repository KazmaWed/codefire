import 'package:bonfire/bonfire.dart';
import 'package:codefire/utilities/languages.dart';
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

class Level0104 extends StatefulWidget {
  const Level0104({super.key, this.initialCode});
  final String? initialCode;

  @override
  State<Level0104> createState() => _Level0104State();
}

class _Level0104State extends State<Level0104> {
  final levelController = LevelController(
    initialCode: '',
    mapJsonPath: 'tiled/level_01_04.json',
    hintTextList: {
      Language.japanese: [
        '私はネクロマンサー、この世界のルールを知ってるよ！',
        'コードフィールドを見てみて、コマンドがなにも書いてないよ！\nこのままだとディノロボくんは一歩も動けないね…',
        'でも大丈夫！君がコマンドを入力すれば、ディノロボくんはその通りに動いてくれるはずだよ♩\nでも「下に進む」のコマンドは何だったかな…\n',
        'そうだ！コマンドがわからない時は、コードフィールドの上にある矢印ボタンを押してみて\n自動でコマンド入力されるはずだよ！',
        'コマンドはパソコンのキーボードを使って入力や編集することもできるから試してみて♩',
      ],
      Language.english: [
        'I am Necrom, I know the rules of this world!',
        'Look at the code field, there are no commands on it! Dino-Robo won\'t be able to take a step...',
        'But don\'t worry! If you enter commands in the field, Dino-Robo will move accordingly♩\nBut what was the command for "go down"...',
        'If you don\'t know the command too, try pressing arrow buttons above the code field. It should automatically enter the command!',
        'Commands can also be entered and edited using a keyboard♩',
      ],
    },
    playerPosition: Vector2(7, 9),
    roboDinoPosition: Vector2(3, 5),
    minimumStep: 8,
    minimumCommand: 3,
    nextMap: const TopScreen(),
  );
  final levelId = 0;
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
                onClear: () {
                  onClear();
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
