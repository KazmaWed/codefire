import 'package:bonfire/bonfire.dart';
import 'package:codefire/decorations/arch_gate.dart';
import 'package:codefire/npc/necromancer.dart';
import 'package:codefire/npc/npc_robo_dino.dart';
import 'package:codefire/player/player_bandit.dart';
export 'package:codefire/player/player_bandit.dart';
export 'package:codefire/decorations/arch_gate.dart';
export 'package:codefire/npc/necromancer.dart';
export 'package:codefire/npc/npc_robo_dino.dart';
export 'package:codefire/npc/npc_robo_dino_sprite.dart';
export 'package:codefire/player/player_bandit_sprite.dart';

class Dungeon02Controller {
  Dungeon02Controller();

  final Set<int> _activatedButtons = {};
  final Set<int> allButtons = {};

  static const tileSize = 48.0; // タイルのサイズ定義

  late NpcNecromancer necromancer;

  final player = PlayerBandit(
    Vector2(tileSize * 10, tileSize * 12),
    initDirection: Direction.up,
    tileSize: tileSize,
  );

  final robo = NpcRoboDino(
    Vector2(tileSize * 8, tileSize * 12),
    tileSize: tileSize,
  );

  late final ArchGateDecoration archGate;

  bool allActivated() {
    return _activatedButtons.containsAll(allButtons);
  }

  void activate(int buttonId) {
    _activatedButtons.add(buttonId);
  }
}
