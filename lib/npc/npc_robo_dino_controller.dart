import 'package:bonfire/bonfire.dart';
import 'package:codefire/npc/npc_robo_dino.dart';

class NpcRoboDinoController extends StateController<NpcRoboDino> {
  List<Map<String, dynamic>> commandList = [];
  Vector2? startPosition;
  Map<String, dynamic>? moving;
  double haveMoved = 0;
  Vector2? _nextPosition;

  Vector2 getNextPosition() {
    final now = component!.position;
    late Vector2 dif;
    if (moving!['direction'] == 'up') {
      dif = Vector2(0, -component!.tileSize * moving!['count']);
    } else if (moving!['direction'] == 'down') {
      dif = Vector2(0, component!.tileSize * moving!['count']);
    } else if (moving!['direction'] == 'left') {
      dif = Vector2(-component!.tileSize * moving!['count'], 0);
    } else {
      dif = Vector2(component!.tileSize * moving!['count'], 0);
    }
    return now + dif;
  }

  void commandInput(List<Map<String, dynamic>> input) {
    if (moving == null && commandList.isEmpty) {
      commandList = input;
    }
  }

  void initialize() {
    commandList = [];
    startPosition = null;
    moving = null;
    haveMoved = 0;
    _nextPosition = null;
  }

  @override
  void update(double dt, NpcRoboDino component) {
    // 次のコマンドがなければ終了
    if (moving == null) {
      component.idle();
    }

    if (commandList.isNotEmpty && moving == null) {
      startPosition = component.position.xy;
      moving = commandList.first;
      _nextPosition = getNextPosition();
      commandList.removeAt(0);
      haveMoved = 0;
    }

    if (moving != null) {
      if (moving!['direction'] == 'up') {
        component.moveUp(component.speed);
        haveMoved = (component.position.y - startPosition!.y).abs();
      } else if (moving!['direction'] == 'down') {
        component.moveDown(component.speed);
        haveMoved = (component.position.y - startPosition!.y).abs();
      } else if (moving!['direction'] == 'left') {
        component.moveLeft(component.speed);
        haveMoved = (component.position.x - startPosition!.x).abs();
      } else {
        component.moveRight(component.speed);
        haveMoved = (component.position.x - startPosition!.x).abs();
      }
    }

    // 移動距離を満たしたらコマンド終了
    if (moving != null && component.tileSize * moving!['count'] <= haveMoved) {
      component.position = _nextPosition!;
      moving = null;
      haveMoved = 0;
    }
  }
}
