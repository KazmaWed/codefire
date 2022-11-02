import 'package:bonfire/bonfire.dart';
import 'package:codefire/npc/npc_robo_dino.dart';

class NpcRoboDinoController extends StateController<NpcRoboDino> {
  List<Map<String, dynamic>> commandList = [];
  Vector2? startPosition;
  Map<String, dynamic>? command;
  double haveMoved = 0;
  Vector2? _nextPosition;

  Vector2 getNextPosition() {
    final now = component!.position;
    late Vector2 dif;
    if (command!['direction'] == 'up') {
      dif = Vector2(0, -component!.tileSize * command!['count']);
    } else if (command!['direction'] == 'down') {
      dif = Vector2(0, component!.tileSize * command!['count']);
    } else if (command!['direction'] == 'left') {
      dif = Vector2(-component!.tileSize * command!['count'], 0);
    } else {
      dif = Vector2(component!.tileSize * command!['count'], 0);
    }
    return now + dif;
  }

  void commandInput(List<Map<String, dynamic>> input) {
    if (command == null && commandList.isEmpty) {
      commandList = input;
    }
  }

  void initialize() {
    commandList = [];
    startPosition = null;
    command = null;
    haveMoved = 0;
    _nextPosition = null;
  }

  @override
  void update(double dt, NpcRoboDino component) {
    // if (component.isDead) {
    //   return;
    // }

    // コマンド待機中
    if (command == null) {
      component.idle();
    }

    // 次のコマンド受付
    if (commandList.isNotEmpty && command == null) {
      startPosition = component.position.xy; // スタート位置
      _nextPosition = getNextPosition(); // 次の移動先
      command = commandList.first; // コマンド
      commandList.removeAt(0); // コマンドリスト
      haveMoved = 0; // 移動距離初期化
    }

    // コマンド実行中
    if (command != null) {
      if (command!['direction'] == 'up') {
        component.moveUp(component.speed);
        haveMoved = (component.position.y - startPosition!.y).abs();
      } else if (command!['direction'] == 'down') {
        component.moveDown(component.speed);
        haveMoved = (component.position.y - startPosition!.y).abs();
      } else if (command!['direction'] == 'left') {
        component.moveLeft(component.speed);
        haveMoved = (component.position.x - startPosition!.x).abs();
      } else {
        component.moveRight(component.speed);
        haveMoved = (component.position.x - startPosition!.x).abs();
      }
    }

    // 移動距離を満たしたらコマンド終了
    if (component.tileSize * command!['count'] <= haveMoved) {
      component.position = _nextPosition!;
      _nextPosition = null;
      command = null;
      haveMoved = 0;
      // if (commandList.isEmpty) {
      //   component.die();
      // }
    }
  }
}
