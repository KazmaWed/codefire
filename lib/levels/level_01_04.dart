import 'package:bonfire/bonfire.dart';
import 'package:codefire/levels/level_controller.dart';
import 'package:codefire/levels/level_widget.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/view/common_component/codefire_field.dart';
import 'package:codefire/view/common_component/codefire_scaffold.dart';
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
    // hintTextList: [],
    playerPosition: Vector2(7, 9),
    roboDinoPosition: Vector2(2, 8),
    minimumStep: 8,
    minimumCommand: 3,
    nextMap: const CodefireMainScreen(),
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
