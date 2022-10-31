import 'package:bonfire/bonfire.dart';

class CameraTarget extends SimpleNpc {
  CameraTarget({
    required this.player,
    required this.components,
  }) : super(
          size: Vector2.zero(),
          position: Vector2.zero(),
          speed: 40,
        );

  final Player player;
  final List<GameComponent> components;

  @override
  void update(double dt) {
    super.update(dt);

    final mapCenter = player.gameRef.map.center;
    var componentPositionSum = Vector2.zero();
    for (var component in components) {
      componentPositionSum += component.position;
    }
    final cameraPosition =
        (mapCenter * 2 + player.position + componentPositionSum) / (3.0 + components.length);
    position = cameraPosition;
  }
}
