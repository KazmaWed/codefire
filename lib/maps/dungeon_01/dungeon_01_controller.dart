import 'package:bonfire/bonfire.dart';
import 'package:codefire/decorations/arch_gate.dart';
import 'package:codefire/npc/invisible_npc_for_camera.dart';
import 'package:codefire/npc/necromancer.dart';
import 'package:codefire/npc/npc_robo_dino.dart';
import 'package:codefire/player/player_bandit.dart';
export 'package:codefire/player/player_bandit.dart';
export 'package:codefire/decorations/arch_gate.dart';
export 'package:codefire/npc/necromancer.dart';
export 'package:codefire/npc/npc_robo_dino.dart';
export 'package:codefire/npc/npc_robo_dino_sprite.dart';
export 'package:codefire/player/player_bandit_sprite.dart';

class Dungeon01Controller {
  Dungeon01Controller();

  final Set<int> _activatedButtons = {};
  final Set<int> allButtons = {};

  final hintTextList = [
    '私はネクロマンサー、この世界のルールを知っている者',
    'さて、画面左側に白い枠が見えるだろう、あれだ「コードフィールド」だ',
    'コードフィールドの左下に再生ボタンが見えるはずだ、まずはそれを押してみなさい',
    '扉が開かれるはずだ',
    'うまく行かないときはリセットボタンを押してみなさい、再生ボタンのちょうど左側にある',
  ];

  static const tileSize = 48.0;
  // static final playerPosition = Vector2(9, 7);
  static final playerPosition = Vector2(9, 7);

  late final CameraTarget cameraTarget;
  late final ArchGateDecoration archGate;
  late final NpcNecromancer necromancer;

  final PlayerBandit player = PlayerBandit(
    playerPosition * tileSize,
    initDirection: Direction.up,
    tileSize: tileSize,
  );
  final robo = NpcRoboDino(
    Vector2(tileSize * 6, tileSize * 9),
    tileSize: tileSize,
  );

  final joystick = Joystick(
    // キーボード用入力の設定
    keyboardConfig: KeyboardConfig(
      keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows, // キーボードの矢印とWASDを有効化
      // acceptedKeys: [LogicalKeyboardKey.space], // キーボードのスペースバーを有効化
    ),
  );

  bool allActivated() {
    return _activatedButtons.containsAll(allButtons);
  }

  void activate(int buttonId) {
    _activatedButtons.add(buttonId);
  }
}
