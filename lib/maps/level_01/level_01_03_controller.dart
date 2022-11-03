import 'package:bonfire/bonfire.dart';
import 'package:codefire/decorations/arch_gate.dart';
import 'package:codefire/maps/level_01/level_01_04_screen.dart';
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

class Level0103Controller {
  final showCollisionArea = false;
  static const initialCode = '''moveUp(4);\n''';
  final jsonPath = 'tiled/level_01_03.json';
  final hintTextList = [
    '私はネクロマンサー、自己紹介が好き',
    'さて、今回も再生ボタンを押すだけでは扉は開かないぞ\n上に進んでから、そのあと左に進むようにコマンドを送らなければダメだ',
    '「moveUp(4);」の次の行に「moveLeft(2);」と入力してみるといい\n入力が面倒臭い場合は、コードフィールド上の「←」ボタンを押してみるといいだろう',
    'ふむ、だいぶ分かってきたぞ、という顔をしているな…\nさあ、その手で試してみるんだ',
  ];

  final Widget nextMap = const Level0104Screen();

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
