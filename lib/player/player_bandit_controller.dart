import 'package:bonfire/bonfire.dart';
import 'package:codefire/player/player_bandit.dart';
import 'package:codefire/utilities/extentions.dart';

class PlayerBanditController extends StateController<PlayerBandit> {
  SimpleNpc cameraCenterComponent = SimpleNpc(
    position: Vector2.zero(),
    size: Vector2.zero(),
  );

  Vector2 _mapCenter = Vector2.zero();
  String? _moveTo;

  @override
  void onReady(PlayerBandit component) {
    super.onReady(component);
    _mapCenter = component.gameRef.map.center;
  }

  @override
  void update(double dt, PlayerBandit component) {
    if (_moveTo != null) {
      switch (_moveTo) {
        case 'up':
          component.moveUp(component.speed);
          break;
        case 'down':
          component.moveDown(component.speed);
          break;
        case 'left':
          component.moveLeft(component.speed);
          break;
        case 'right':
          component.moveRight(component.speed);
          break;
        case 'upRight':
          component.moveUpRight(component.speed / 1.41, component.speed / 1.41);
          break;
        case 'upLeft':
          component.moveUpLeft(component.speed / 1.41, component.speed / 1.41);
          break;
        case 'downRight':
          component.moveDownRight(component.speed / 1.41, component.speed / 1.41);
          break;
        case 'downLeft':
          component.moveDownLeft(component.speed / 1.41, component.speed / 1.41);
          break;
        default:
          component.idle();
          break;
      }
    }
    cameraCenterComponent.position = (_mapCenter * 2 + component.position) / 3;
  }

  void moveToPoint(Vector2 point) {
    _moveTo = (point - component!.center).toOctaDirectionStr();
  }

  void stopMoving() {
    _moveTo = null;
    component!.idle();
  }
}
