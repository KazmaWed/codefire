import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

class PlayerBandit extends SimplePlayer with ObjectCollision {
  PlayerBandit(
    position, {
    required this.tileSize,
    required this.spriteSheet,
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
          position: position + imageShift,
          initDirection: initDirection,
          speed: tileSize * 5,
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
  final SpriteSheet spriteSheet;
  final double tileSize;

  static final imageShift = Vector2(0, -12);
}
