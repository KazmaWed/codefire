import 'package:bonfire/bonfire.dart';
import 'package:codefire/npc/npc_robo_dino.dart';

class NpcRoboDinoController extends StateController<NpcRoboDino> {
  // List<String> commandList = ['up', 'left', 'left', 'down', 'right', 'right'];
  List<String> commandList = [];
  Vector2? startPosition;
  String? moving;
  double haveMoved = 0;
  Vector2? nextPosition;

  Vector2 getNextPosition() {
    final now = component!.position;
    late Vector2 dif;
    if (moving == 'up') {
      dif = Vector2(0, -component!.tileSize);
    } else if (moving == 'down') {
      dif = Vector2(0, component!.tileSize);
    } else if (moving == 'left') {
      dif = Vector2(-component!.tileSize, 0);
    } else {
      dif = Vector2(component!.tileSize, 0);
    }
    return now + dif;
  }

  void commandInput(List<String> input) {
    if (moving != null && commandList.isEmpty) {
      commandList = input;
    }
  }

  @override
  void update(double dt, NpcRoboDino component) {
    if (moving == null) {
      component.idle();
    }

    if (commandList.isNotEmpty && moving == null && nextPosition == null) {
      startPosition = component.position.xy;
      moving = commandList.first;
      nextPosition = getNextPosition();
      commandList.removeAt(0);
      haveMoved = 0;
    }

    if (moving != null && nextPosition != null) {
      if (moving == 'up') {
        component.moveUp(component.speed);
        haveMoved = (component.position.y - startPosition!.y).abs();
      } else if (moving == 'down') {
        component.moveDown(component.speed);
        haveMoved = (component.position.y - startPosition!.y).abs();
      } else if (moving == 'left') {
        component.moveLeft(component.speed);
        haveMoved = (component.position.x - startPosition!.x).abs();
      } else {
        component.moveRight(component.speed);
        haveMoved = (component.position.x - startPosition!.x).abs();
      }
      print(haveMoved);
    }

    if (component.tileSize <= haveMoved) {
      moving = null;
      nextPosition = null;
      haveMoved = 0;
    }
  }
}
