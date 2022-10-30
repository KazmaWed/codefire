import 'package:bonfire/bonfire.dart';

class ArchGateDecoration extends GameDecoration with ObjectCollision {
  ArchGateDecoration({
    required this.tileSize,
    required this.initialPosition,
    // required this.id,
  }) : super.withSprite(
          sprite: Sprite.load(imagePathClose),
          position: initialPosition,
          size: Vector2(tileSize * 3, tileSize * 3),
        ) {
    setupCollision(
      CollisionConfig(collisions: [
        CollisionArea.rectangle(
          size: Vector2(tileSize * 3, tileSize * 1),
          align: Vector2(0, tileSize * 2),
        ),
      ]),
    );
  }

  final double tileSize;
  final Vector2 initialPosition;
  // final int id;

  static const imagePathClose = 'decorations/arch_gate_close.png';
  static const imagePathOpen = 'decorations/arch_gate_open.png';

  void openGate() async {
    sprite = await Sprite.load(imagePathOpen);
    setupCollision(
      CollisionConfig(collisions: [
        CollisionArea.rectangle(
          size: Vector2(tileSize * 1, tileSize * 1),
          align: Vector2(0, tileSize * 2),
        ),
        CollisionArea.rectangle(
          size: Vector2(tileSize * 1, tileSize * 1),
          align: Vector2(tileSize * 2, tileSize * 2),
        ),
      ]),
    );
  }
}
