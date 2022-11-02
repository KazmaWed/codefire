import 'package:bonfire/bonfire.dart';
import 'package:codefire/decorations/arch_gate.dart';
import 'package:codefire/maps/level_01/level_01_03_screen.dart';
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

class Level0102Controller {
  static const initialCode = '''moveUp(2);\n''';
  final jsonPath = 'tiled/level_01_02.json';
  final hintTextList = [
    '私はネクロマンサー、この世界のルールを知っている',
    'さて、今回は再生ボタンを押すだけでは扉は開かないぞ\n扉を開くには青いスイッチを押さなければいけない',
    'コードフィールドに「moveUp(2);」と書かれているのが見えるだろう\nあれを「moveUp(4);」に書き換えてから再生してみなさい',
    'それで扉が開かれるはずだ',
    'うまく行かないときはリセットボタンを押すんだぞ',
  ];

  final Widget nextMap = const Level0103Screen();

  static const tileSize = 48.0;
  static final playerPosition = Vector2(7, 9);
  static final roboDinoPosition = Vector2(3, 8);

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
