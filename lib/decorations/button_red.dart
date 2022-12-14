import 'package:codefire/npc/invisible_npc_for_camera.dart';
import 'package:bonfire/bonfire.dart';
import 'package:codefire/utilities/sounds.dart';
import 'package:codefire/view/level_screen/level_controller.dart';

class ButtonRedDecoration extends GameDecoration with Sensor {
  ButtonRedDecoration({
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
        size: Vector2.all(tileSize) * 1 / 2,
        align: Vector2.all(tileSize) * 1 / 4 - positionShift,
      ),
    ]);
  }

  final Vector2 initPosition;
  final double tileSize;
  final int id;
  final PlayerBandit player;
  final Function callback;
  bool activated = false;

  static final imageSize = Vector2(8, 12);
  static final positionShift = (Vector2.all(16) - imageSize) * 3 / 2;
  static const imagePathOff = 'decorations/button_red_off.png';
  static const imagePathOn = 'decorations/button_red_on.png';

  @override
  void onContact(GameComponent component) async {
    if (!activated && (component is NpcRoboDino || component is PlayerBandit)) {
      Sounds.buttonOff();
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

  @override
  int get priority => LayerPriority.MAP + 1;
}
