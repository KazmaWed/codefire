import 'package:bonfire/bonfire.dart';
import 'package:codefire/npc/necromancer_sprite.dart';
import 'package:codefire/player/player_bandit.dart';
import 'package:codefire/utilities/sounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NpcNecromancer extends SimpleNpc with ObjectCollision, MouseGesture {
  NpcNecromancer(
    Vector2 initialPosition, {
    required this.tileSize,
    required this.cameraCenterComponent,
    Direction initDirection = Direction.right,
    this.hintTextList,
  }) : super(
          animation: SimpleDirectionAnimation(
            idleLeft: spriteSheet.createAnimation(row: 0, stepTime: 0.3, from: 4, to: 8).asFuture(),
            idleRight:
                spriteSheet.createAnimation(row: 0, stepTime: 0.3, from: 0, to: 4).asFuture(),
            runLeft: spriteSheet.createAnimation(row: 1, stepTime: 0.06, from: 4, to: 8).asFuture(),
            runRight:
                spriteSheet.createAnimation(row: 1, stepTime: 0.06, from: 0, to: 4).asFuture(),
          ),
          size: Vector2.all(tileSize * 1.5),
          position: initialPosition + Vector2(-tileSize / 4, -tileSize / 4 - spriteShift),
          initDirection: initDirection,
          speed: tileSize * 3,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(tileSize * 1, tileSize * 1.4),
            align: Vector2(tileSize * 0.25, tileSize * 0 + spriteShift),
          ),
        ],
      ),
    );
  }

  static final SpriteSheet spriteSheet = NpcNecromancerSprite.sheet;
  final double tileSize;
  final GameComponent cameraCenterComponent;
  final List<String>? hintTextList;

  static const spriteShift = 14.0;
  final radiusVision = 1;
  bool lookAtPlayer = false;

  @override
  Vector2 get center => super.center + Vector2(0, tileSize * 4 / 16);

  @override
  void update(double dt) {
    super.update(dt);
    seePlayer(
      observed: (player) {
        if (!lookAtPlayer) {
          lookAtPlayer = true;
          _showTalk();
        }
      },
      notObserved: () {
        if (lookAtPlayer) {
          lookAtPlayer = false;
        }
      },
      radiusVision: tileSize * radiusVision,
    );
  }

  @override
  void onMouseTap(MouseButton button) {
    if (lookAtPlayer) {
      _showTalk();
    }
  }

  @override
  void onMouseCancel() {}

  void _showTalk() {
    if (hintTextList != null) {
      // 効果音
      Sounds.interaction();
      // プレイヤー停止
      (gameRef.player! as PlayerBandit).controller.stopMoving();
      gameRef.player!.idle();
      TalkDialog.show(
        gameRef.map.gameRef.context,
        hintTextList!.map((element) => Say(text: [TextSpan(text: element)])).toList(),
        logicalKeyboardKeysToNext: [LogicalKeyboardKey.space],
        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
        padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width / 3) + const EdgeInsets.all(32),
        onChangeTalk: (value) => Sounds.interaction(),
        onFinish: () {
          Sounds.interaction();
          gameRef.camera.moveToTargetAnimated(cameraCenterComponent);
        },
      );
    }
  }

  // @override
  // bool onCollision(GameComponent component, bool active) {
  //   _showTalk();
  //   return super.onCollision(component, active);
  // }
}
