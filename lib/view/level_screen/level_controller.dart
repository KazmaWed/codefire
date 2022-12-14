import 'package:bonfire/bonfire.dart';
import 'package:codefire/decorations/arch_gate.dart';
import 'package:codefire/decorations/button_blue.dart';
import 'package:codefire/npc/invisible_npc_for_camera.dart';
import 'package:codefire/npc/necromancer.dart';
import 'package:codefire/npc/npc_robo_dino.dart';
import 'package:codefire/player/player_bandit.dart';
import 'package:codefire/utilities/languages.dart';
import 'package:flutter/material.dart';
export 'package:codefire/player/player_bandit.dart';
export 'package:codefire/decorations/arch_gate.dart';
export 'package:codefire/npc/necromancer.dart';
export 'package:codefire/npc/npc_robo_dino.dart';
export 'package:codefire/npc/npc_robo_dino_sprite.dart';
export 'package:codefire/player/player_bandit_sprite.dart';

class LevelController {
  LevelController({
    this.showCollisionArea = false,
    this.hintTextList,
    required this.initialCode,
    required this.mapJsonPath,
    required this.playerPosition,
    required this.roboDinoPosition,
    required this.nextMap,
    required this.minimumStep,
    required this.minimumCommand,
  });
  final String initialCode;
  final String mapJsonPath;
  final Map<Language, List<String>>? hintTextList;
  final bool showCollisionArea;
  final Vector2 playerPosition;
  final Vector2 roboDinoPosition;
  final Widget nextMap;
  final int minimumStep;
  final int minimumCommand;

  double get tileSize => 48.0;

  late final CameraTarget cameraTarget;
  late final ArchGateDecoration archGate;
  late final NpcNecromancer necromancer;

  void init() {
    player = PlayerBandit(
      playerPosition * 48.0,
      initDirection: Direction.up,
      tileSize: tileSize,
    );
    robo = NpcRoboDino(
      roboDinoPosition * tileSize,
      tileSize: tileSize,
    );
  }

  late final PlayerBandit player;
  late final NpcRoboDino robo;

  // final joystick = CodefireGameComponents.joystick;

  final Set<ButtonBlueDecoration> allButtonDecorations = {};
  final Set<int> _activatedButtons = {};
  final Set<int> allButtons = {};

  void addButton(ButtonBlueDecoration button) {
    allButtons.add(button.id);
    allButtonDecorations.add(button);
  }

  bool allActivated() {
    return _activatedButtons.containsAll(allButtons);
  }

  void activate(int buttonId) {
    _activatedButtons.add(buttonId);
  }

  void clearLevel() {
    robo.controller.succeed();
  }

  void deactivateAll() {
    for (var element in allButtonDecorations) {
      element.deactivate();
    }
    _activatedButtons.clear();
  }

  Map<String, dynamic> culcScore(BuildContext context, String code) {
    const rowMargin = 4.0;
    int totalStep = robo.controller.totalStep;
    final int commandUsed = _commandCountMap(code)
        .entries
        .map((entry) => entry.value == 0 ? 0 : 1)
        .toList()
        .reduce((value, element) => value + element);
    final int sameCommandUsage = _commandCountMap(code)
        .entries
        .map((entry) => entry.value == 0 ? 0 : entry.value - 1)
        .toList()
        .reduce((value, element) => value + element);

    final star = (totalStep <= minimumStep ? 1 : 0) +
        (commandUsed <= minimumCommand ? 1 : 0) +
        (sameCommandUsage == 0 ? 1 : 0);

    final score = {
      'totalStep': totalStep,
      'commandUsed': commandUsed,
      'sameCommandUsage': sameCommandUsage,
    };

    final Map<String, Map<String, dynamic>> message = {
      'step': {'name': '????????????', 'value': '$totalStep ??????', 'star': totalStep <= minimumStep},
      'command': {
        'name': '?????????????????????',
        'value': '$commandUsed ??????',
        'star': commandUsed <= minimumCommand
      },
      'same': {'name': '??????????????????', 'value': '$sameCommandUsage ???', 'star': sameCommandUsage == 0},
    };

    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: const Text("?????????"),
          content: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message['step']!['name'].toString()),
                  const SizedBox(height: rowMargin),
                  Text(message['command']!['name'].toString()),
                  const SizedBox(height: rowMargin),
                  Text(message['same']!['name'].toString()),
                ],
              ),
              const SizedBox(width: 24),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message['step']!['value'].toString()),
                  const SizedBox(height: rowMargin),
                  Text(message['command']!['value'].toString()),
                  const SizedBox(height: rowMargin),
                  Text(message['same']!['value'].toString()),
                ],
              ),
              const SizedBox(width: 24),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message['step']!['star'] ? '?????????GET' : '-'),
                  const SizedBox(height: rowMargin),
                  Text(message['command']!['star'] ? '?????????GET' : '-'),
                  const SizedBox(height: rowMargin),
                  Text(message['same']!['star'] ? '?????????GET' : '-'),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("?????????"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      }),
    );

    return {
      'star': star,
      'score': score,
      'message': message,
    };
  }

  Map<String, int> _commandCountMap(String code) {
    final moveUp = RegExp(r'moveUp\([0-9]*\)').allMatches(code).length;
    final moveDown = RegExp(r'moveDown\([0-9]*\)').allMatches(code).length;
    final moveLeft = RegExp(r'moveLeft\([0-9]*\)').allMatches(code).length;
    final moveRight = RegExp(r'moveRight\([0-9]*\)').allMatches(code).length;
    final forUsage = RegExp(r'for.?\(.+\;.+\;.+\)').allMatches(code).length;
    final ifUsage = RegExp(r'if.?\(.?\)').allMatches(code).length;
    final output = {
      'moveUp': moveUp,
      'moveDown': moveDown,
      'moveLeft': moveLeft,
      'moveRight': moveRight,
      'for': forUsage,
      'if': ifUsage,
    };
    return output;
  }
}
