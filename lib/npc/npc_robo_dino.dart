import 'package:bonfire/bonfire.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';

class NpcRoboDino extends SimpleNpc
    with ObjectCollision, UseStateController<NpcRoboDinoController> {
  NpcRoboDino(
    Vector2 initialPosition, {
    required this.spriteSheet,
    Direction initDirection = Direction.right,
    required this.tileSize,
  }) : super(
          animation: SimpleDirectionAnimation(
            idleLeft: spriteSheet.createAnimation(row: 0, stepTime: 0.3, from: 4, to: 8).asFuture(),
            idleRight:
                spriteSheet.createAnimation(row: 0, stepTime: 0.3, from: 0, to: 4).asFuture(),
            runLeft: spriteSheet.createAnimation(row: 1, stepTime: 0.06, from: 4, to: 8).asFuture(),
            runRight:
                spriteSheet.createAnimation(row: 1, stepTime: 0.06, from: 0, to: 4).asFuture(),
          ),
          size: Vector2.all(tileSize * 2),
          position: initialPosition + Vector2(-tileSize / 2, -tileSize / 2 - spriteShift),
          initDirection: initDirection,
          speed: tileSize * 3,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(tileSize * 0.9, tileSize * 0.9),
            align: Vector2(tileSize * 0.55, tileSize * 0.55 + spriteShift),
          ),
        ],
      ),
    );
  }

  final SpriteSheet spriteSheet;
  final double tileSize;

  static const spriteShift = 14.0;

  List<String> commandList = ['up', 'left', 'left', 'down', 'right', 'right'];

  @override
  bool onCollision(GameComponent component, bool active) {
    controller.moving = null;
    controller.nextPosition = null;
    controller.haveMoved = 0;

    return true;
  }
}
