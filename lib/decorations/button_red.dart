import 'package:codefire/npc/invisible_npc_for_camera.dart';
import 'package:codefire/player/player_bandit.dart';
import 'package:bonfire/bonfire.dart';

class ButtonRedDecoration extends GameDecoration with Sensor {
  ButtonRedDecoration({
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

  static const imagePathOff = 'decorations/button_red_off.png';
  static const imagePathOn = 'decorations/button_red_on.png';

  @override
  void onContact(GameComponent component) async {
    if (!activated && component is! CameraTarget) {
      callback();
      sprite = await Sprite.load(imagePathOn);
      activated = true;
    }
  }

  @override
  void onContactExit(GameComponent component) async {
    super.onContactExit(component);
    if (activated && component is! CameraTarget) {
      sprite = await Sprite.load(imagePathOff);
      activated = false;
    }
  }
}
