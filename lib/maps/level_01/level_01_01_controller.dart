import 'package:bonfire/bonfire.dart';
import 'package:codefire/decorations/arch_gate.dart';
import 'package:codefire/maps/level_01/level_01_02_screen.dart';
import 'package:codefire/npc/invisible_npc_for_camera.dart';
import 'package:codefire/npc/necromancer.dart';
import 'package:codefire/npc/npc_robo_dino.dart';
import 'package:codefire/player/player_bandit.dart';
import 'package:flutter/material.dart';
export 'package:codefire/player/player_bandit.dart';
export 'package:codefire/decorations/arch_gate.dart';
export 'package:codefire/npc/necromancer.dart';
export 'package:codefire/npc/npc_robo_dino.dart';
export 'package:codefire/npc/npc_robo_dino_sprite.dart';
export 'package:codefire/player/player_bandit_sprite.dart';

class Level0101Controller {
  static const initialCode = '''moveLeft(2);\n''';
  final jsonPath = 'tiled/level_01_01.json';
  final hintTextList = [
    '私はネクロマンサー、この世界のルールを知っている',
    'さて、画面左側に白い枠が見えるだろう、あれは「コードフィールド」だ',
    'コードフィールドの右下に「再生ボタン」が見えるだろう\nまずはそれを押してみなさい',
    '左の部屋のディノロボットがボタンを押して、扉が開かれるはずだ',
    'うまく行かないときはリセットボタンを押してみなさい\n再生ボタンのちょうど左側にある',
  ];

  final Widget nextMap = const Level0102Screen();

  static const tileSize = 48.0;
  static final playerPosition = Vector2(7, 9);
  static final roboDinoPosition = Vector2(4, 6);

  late final CameraTarget cameraTarget;
  late final ArchGateDecoration archGate;
  late final NpcNecromancer necromancer;

  final PlayerBandit player = PlayerBandit(
    playerPosition * tileSize,
    initDirection: Direction.up,
    tileSize: tileSize,
  );
  final robo = NpcRoboDino(
    roboDinoPosition * tileSize,
    tileSize: tileSize,
  );

  final joystick = Joystick(
    // キーボード用入力の設定
    keyboardConfig: KeyboardConfig(
      keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows, // キーボードの矢印とWASDを有効化
      // acceptedKeys: [LogicalKeyboardKey.space], // キーボードのスペースバーを有効化
    ),
  );

  final Set<int> _activatedButtons = {};
  final Set<int> allButtons = {};

  bool allActivated() {
    return _activatedButtons.containsAll(allButtons);
  }

  void activate(int buttonId) {
    _activatedButtons.add(buttonId);
  }
}
