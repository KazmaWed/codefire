import 'package:bonfire/bonfire.dart';
import 'package:codefire/player/player_bandit.dart';

class PlayerBanditController extends StateController<PlayerBandit> {
  SimpleNpc cameraCenterComponent = SimpleNpc(
    position: Vector2.zero(),
    size: Vector2.zero(),
  );

  Vector2 _mapCenter = Vector2.zero();
  Vector2? _moveToPoint;
  Vector2? _lastPosition;

  @override
  void onReady(PlayerBandit component) {
    super.onReady(component);
    stopMoving();
    _mapCenter = component.gameRef.map.center;
  }

  @override
  void update(double dt, PlayerBandit component) {
    if (_moveToPoint != null) {
      final threxhold = component.tileSize / 30;
      final toRight = threxhold < (_moveToPoint!.x - component.center.x);
      final toLeft = threxhold < (component.center.x - _moveToPoint!.x);
      final toUp = threxhold < (component.center.y - _moveToPoint!.y);
      final toDown = threxhold < (_moveToPoint!.y - component.center.y);

      if (toUp) {
        if (toLeft) {
          component.moveUpLeft(component.speed / 1.41, component.speed / 1.41);
        } else if (toRight) {
          component.moveUpRight(component.speed / 1.41, component.speed / 1.41);
        } else {
          component.moveUp(component.speed);
        }
      } else if (toDown) {
        if (toLeft) {
          component.moveDownLeft(component.speed / 1.41, component.speed / 1.41);
        } else if (toRight) {
          component.moveDownRight(component.speed / 1.41, component.speed / 1.41);
        } else {
          component.moveDown(component.speed);
        }
      } else if (toLeft) {
        component.moveLeft(component.speed);
      } else if (toRight) {
        component.moveRight(component.speed);
      } else {
        stopMoving();
      }

      const intervalMilliSec = 100;
      bool lastPositionInterval =
          component.checkInterval('lastPositionInterval', intervalMilliSec, dt);
      if (lastPositionInterval) {
        if (_lastPosition != null && _lastPosition!.distanceTo(component.position).abs() <= 0) {
          stopMoving();
        } else {}
        _lastPosition = component.position.xy;
      }
    }
    cameraCenterComponent.position = (_mapCenter * 2 + component.center) / 3;
  }

  void moveToPoint(Vector2 point) {
    _moveToPoint = point;
  }

  void stopMoving() {
    _moveToPoint = null;
    _lastPosition = null;
    component!.idle();
  }
}
