import 'package:bonfire/bonfire.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/npc/npc_robo_dino_sprite.dart';

class NpcRoboDino extends SimplePlayer
    with ObjectCollision, UseStateController<NpcRoboDinoController> {
  NpcRoboDino(
    Vector2 initialPosition, {
    Direction initDirection = Direction.left,
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
          speed: tileSize * 2.8,
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
    // aboveComponents = true;
  }

  static final SpriteSheet spriteSheet = NpcRoboDinoSprite.sheet;
  final double tileSize;
  static const spriteShift = 14.0;

  @override
  void onMount() {
    super.onMount();
    controller.initialize();
  }

  @override
  bool onCollision(GameComponent component, bool active) {
    controller.endCommand(onCollide: true);
    return true;
  }

  @override
  void die() {
    final dieAnimation = lastDirection == Direction.right
        ? spriteSheet.createAnimation(row: 10, stepTime: 0.2, from: 0, to: 4, loop: false)
        : spriteSheet.createAnimation(row: 10, stepTime: 0.2, from: 4, to: 8, loop: false);

    super.die();
    removeFromParent();
    gameRef.add(
      GameDecorationWithCollision.withAnimation(
        animation: dieAnimation.asFuture(),
        position: position,
        size: size,
        collisions: [CollisionArea.rectangle(size: Vector2.zero())],
      ),
    );
  }
}
