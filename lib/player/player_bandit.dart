import 'package:bonfire/bonfire.dart';
import 'package:codefire/player/player_bandit_controller.dart';
import 'package:codefire/player/player_bandit_sprite.dart';
import 'package:flutter/material.dart';

class PlayerBandit extends SimplePlayer
    with ObjectCollision, UseStateController<PlayerBanditController> {
  PlayerBandit(
    position, {
    required this.tileSize,
    Direction initDirection = Direction.up,
  }) : super(
          animation: SimpleDirectionAnimation(
            idleLeft: spriteSheet.createAnimation(row: 1, stepTime: 0.3, from: 4, to: 8).asFuture(),
            idleRight:
                spriteSheet.createAnimation(row: 1, stepTime: 0.3, from: 0, to: 4).asFuture(),
            runLeft: spriteSheet.createAnimation(row: 3, stepTime: 0.1, from: 4, to: 8).asFuture(),
            runRight: spriteSheet.createAnimation(row: 3, stepTime: 0.1, from: 0, to: 4).asFuture(),
          ),
          size: Vector2.all(tileSize * 2),
          position: position - Vector2.all(tileSize / 2) + imageShift,
          initDirection: initDirection,
          speed: tileSize * 4,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(tileSize * 0.2, tileSize - 32),
            align: Vector2(tileSize * 0.9, tileSize + 32) + imageShift,
          ),
        ],
      ),
    );
    setupMoveToPositionAlongThePath(
      pathLineColor: Colors.transparent,
      barriersCalculatedColor: Colors.transparent,
    );
  }
  static final SpriteSheet spriteSheet = PlayerBanditSprite.sheet;
  final double tileSize;

  static final imageShift = Vector2(0, -12);

  @override
  bool onCollision(GameComponent component, bool active) {
    controller.stopMoving();
    return true;
  }

  @override
  Vector2 get center => super.center + Vector2(0, tileSize * 4 / 16);
}
