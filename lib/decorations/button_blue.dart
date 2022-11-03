import 'package:bonfire/bonfire.dart';
import 'package:codefire/npc/invisible_npc_for_camera.dart';
import 'package:codefire/player/player_bandit.dart';

class ButtonBlueDecoration extends GameDecoration with Sensor {
  ButtonBlueDecoration({
    required this.initPosition,
    required this.tileSize,
    required this.id,
    required this.player,
    required this.callback,
  }) : super.withSprite(
          sprite: Sprite.load(imagePathOff),
          position: initPosition + positionShift,
          size: imageSize * tileSize / 16,
        ) {
    setupSensorArea(areaSensor: [
      CollisionArea.rectangle(
        size: Vector2.all(tileSize) * 1 / 3,
        align: Vector2.all(tileSize) * 1 / 3 - positionShift,
      ),
    ]);
  }

  final Vector2 initPosition;
  final double tileSize;
  final int id;
  final PlayerBandit player;
  final Function callback;
  bool activated = false;

  static final imageSize = Vector2(8, 10);
  static final positionShift = (Vector2.all(16) - Vector2(8, 12)) * 3 / 2;
  static const imagePathOff = 'decorations/button_blue_off.png';
  static const imagePathOn = 'decorations/button_blue_on.png';

  @override
  void onContact(GameComponent component) async {
    if (!activated && component is! CameraTarget) {
      callback();
      sprite = await Sprite.load(imagePathOn);
      activated = true;
    }
  }

  void deactivate() async {
    sprite = await Sprite.load(imagePathOff);
    activated = false;
  }
}
