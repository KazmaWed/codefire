import 'package:bonfire/bonfire.dart';
import 'package:codefire/decorations/arch_gate.dart';
import 'package:codefire/npc/invisible_npc_for_camera.dart';
import 'package:codefire/npc/necromancer.dart';
import 'package:codefire/npc/npc_robo_dino.dart';
import 'package:codefire/player/player_bandit.dart';
import 'package:codefire/view/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
export 'package:codefire/player/player_bandit.dart';
export 'package:codefire/decorations/arch_gate.dart';
export 'package:codefire/npc/necromancer.dart';
export 'package:codefire/npc/npc_robo_dino.dart';
export 'package:codefire/npc/npc_robo_dino_sprite.dart';
export 'package:codefire/player/player_bandit_sprite.dart';

class Level0104Controller {
  final showCollisionArea = false;
  static const initialCode = '';
  final jsonPath = 'tiled/level_01_04.json';
  final hintTextList = [
    '私はネクロマンサー、話す時も振り返らない',
    'コマンドフィールドを見てみろ、まだ何も書かれていない\n再生ボタンを押しても何も動かないだろう',
    '自分でコマンドを入力して、ディノロボットをスイッチまで導くのだ！',
  ];

  final Widget nextMap = const CodefireMainScreen();

  static const tileSize = 48.0;
  static final playerPosition = Vector2(7, 9);
  static final roboDinoPosition = Vector2(4, 8);

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
