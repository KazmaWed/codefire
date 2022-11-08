import 'package:bonfire/bonfire.dart';
import 'package:codefire/view/common_component/codefire_components.dart';
import 'package:codefire/view/level_screen/level_widget.dart';
import 'package:codefire/view/level_screen/level_controller.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/view/common_component/codefire_field.dart';
import 'package:codefire/view/top_screen/top_screen_component.dart';
import 'package:codefire/view/top_screen/top_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:highlight/languages/javascript.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({
    super.key,
    this.initialCode,
    required this.showCollisionArea,
    required this.mapJsonPath,
    required this.levelId,
    required this.stageId,
    required this.hintTextList,
    required this.playerPosition,
    required this.roboDinoPosition,
    required this.minimumStep,
    required this.minimumCommand,
    required this.nextMap,
  });
  final String? initialCode;
  final bool showCollisionArea;
  final String mapJsonPath;
  final List<String> hintTextList;
  final Vector2 playerPosition;
  final Vector2 roboDinoPosition;
  final int minimumStep;
  final int minimumCommand;
  final Widget nextMap;
  final int levelId;
  final int stageId;

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  @override
  Widget build(BuildContext context) {
    final levelController = LevelController(
      showCollisionArea: widget.showCollisionArea,
      initialCode: widget.initialCode ?? '',
      mapJsonPath: widget.mapJsonPath,
      hintTextList: widget.hintTextList,
      playerPosition: widget.playerPosition,
      roboDinoPosition: widget.roboDinoPosition,
      minimumStep: widget.minimumStep,
      minimumCommand: widget.minimumCommand,
      nextMap: widget.nextMap,
    );

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
        if (mainScreenController.levels[widget.levelId]['maps'][widget.stageId]['star'] <
            result['star']) {
          mainScreenController.levels[widget.levelId]['maps'][widget.stageId]['star'] =
              result['star'];
        }
      }

      return CodefireScaffold(
        floatingActinButton: const GoBackFloatingButton(),
        body: Stack(
          children: [
            Positioned(
              right: 24,
              bottom: 24,
              child: ObjectiveText(
                context: context,
                step: widget.minimumStep,
                command: widget.minimumCommand,
              ),
            ),
            Row(
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
            Positioned(
              right: 24,
              bottom: 24,
              child: ObjectiveText(
                context: context,
                step: widget.minimumStep,
                command: widget.minimumCommand,
              ),
            ),
          ],
        ),
      );
    });
  }
}
