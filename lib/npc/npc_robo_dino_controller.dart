import 'package:bonfire/bonfire.dart';
import 'package:codefire/npc/npc_robo_dino.dart';

class NpcRoboDinoController extends StateController<NpcRoboDino> {
  List<Map<String, dynamic>> commandList = [];
  Map<String, dynamic>? command;
  Vector2? startPosition;
  Vector2? _nextPosition;
  double haveMoved = 0;
  int _totalStep = 0;
  bool succeeded = false;

  int get totalStep => _totalStep + (_totalStep / component!.tileSize).ceil();

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

  void nextCommand() {
    startPosition = component!.position.xy; // スタート位置
    command = commandList.first; // コマンド
    commandList.removeAt(0); // コマンドリスト
    haveMoved = 0; // 移動距離初期化
    _nextPosition = getNextPosition(); // 次の移動先
  }

  void excecuteCommand() {
    if (command!['direction'] == 'up') {
      component!.moveUp(component!.speed);
      haveMoved = (component!.position.y - startPosition!.y).abs();
    } else if (command!['direction'] == 'down') {
      component!.moveDown(component!.speed);
      haveMoved = (component!.position.y - startPosition!.y).abs();
    } else if (command!['direction'] == 'left') {
      component!.moveLeft(component!.speed);
      haveMoved = (component!.position.x - startPosition!.x).abs();
    } else {
      component!.moveRight(component!.speed);
      haveMoved = (component!.position.x - startPosition!.x).abs();
    }
  }

  void endCommand({bool onCollide = false}) {
    if (!onCollide) component!.position = _nextPosition!;
    _totalStep += (haveMoved / component!.tileSize).round();
    command = null;
    haveMoved = 0;
    if (commandList.isEmpty && !succeeded) component!.die();
  }

  void succeed() {
    succeeded = true;
  }

  @override
  void update(double dt, NpcRoboDino component) {
    // ガード
    if (component.isDead) {
      return;
    }
    // コマンド待機中
    if (command == null) {
      component.idle();
    }
    // 次のコマンド受付
    if (commandList.isNotEmpty && command == null) {
      nextCommand();
    }
    // コマンド実行中
    if (command != null) {
      excecuteCommand();
    }
    // 移動距離を満たしたらコマンド終了
    if (command != null && component.tileSize * command!['count'] <= haveMoved) {
      endCommand();
    }
  }
}
