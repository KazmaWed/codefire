import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

class PlayerBandit extends SimplePlayer with ObjectCollision {
  PlayerBandit(
    position, {
    required this.spriteSheet,
    Direction initDirection = Direction.up,
  }) : super(
          animation: SimpleDirectionAnimation(
            idleLeft: spriteSheet.createAnimation(row: 1, stepTime: 0.4, from: 4, to: 8).asFuture(),
            idleRight:
                spriteSheet.createAnimation(row: 1, stepTime: 0.4, from: 0, to: 4).asFuture(),
            runLeft: spriteSheet.createAnimation(row: 3, stepTime: 0.1, from: 4, to: 8).asFuture(),
            runRight: spriteSheet.createAnimation(row: 3, stepTime: 0.1, from: 0, to: 4).asFuture(),
          ),
          size: charactorSize,
          position: position,
          initDirection: initDirection,
          speed: 32 * 3,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: charactorSize * 1 / 2,
            align: charactorSize * 1 / 4,
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

  static final charactorSize = Vector2(32, 32);
}
