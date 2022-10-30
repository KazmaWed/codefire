import 'package:bonfire/bonfire.dart';
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
          position: initPosition,
          size: Vector2(tileSize, tileSize),
        ) {
    setupSensorArea(areaSensor: [
      CollisionArea.rectangle(
        size: Vector2(tileSize, tileSize) * 1 / 3,
        align: Vector2(tileSize, tileSize) * 1 / 3,
      ),
    ]);
    priority = 0;
  }

  final Vector2 initPosition;
  final double tileSize;
  final int id;
  final PlayerBandit player;
  final Function callback;
  bool activated = false;

  static const imagePathOff = 'decorations/button_blue_off.png';
  static const imagePathOn = 'decorations/button_blue_on.png';

  @override
  void onContact(GameComponent component) async {
    if (!activated) {
      callback();
      sprite = await Sprite.load(imagePathOn);
      activated = true;
    }
  }
}
