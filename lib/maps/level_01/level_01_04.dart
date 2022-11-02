import 'package:codefire/decorations/button_blue.dart';
import 'package:codefire/maps/level_01/level_01_04_controller.dart';
import 'package:codefire/npc/invisible_npc_for_camera.dart';
import 'package:codefire/utilities/exit_map_sensor.dart';
import 'package:codefire/view/common_component/codefire_components.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';

class Level0104 extends StatefulWidget {
  const Level0104({Key? key, required this.focus}) : super(key: key);
  final FocusNode focus;
  @override
  State<Level0104> createState() => _Level0104State();
}

class _Level0104State extends State<Level0104> {
  @override
  Widget build(BuildContext context) {
    final controller = Level0104Controller();
    controller.cameraTarget = CameraTarget(
      player: controller.player,
      components: [controller.robo],
    );

    // 画面
    return BonfireWidget(
      // showCollisionArea: true,
      // クリックで移動
      onTapDown: ((game, screenPosition, worldPosition) {
        widget.focus.requestFocus();
        (game.player! as PlayerBandit).controller.moveToPoint(worldPosition);
      }),
      onTapUp: (game, screenPosition, worldPosition) {
        (game.player! as PlayerBandit).controller.stopMoving();
      },
      // マップ用jsonファイル読み込み
      map: WorldMapByTiled(
        controller.jsonPath,
        forceTileSize: Vector2(
          Level0104Controller.tileSize,
          Level0104Controller.tileSize,
        ),
        objectsBuilder: {
          'necromancer': (properties) {
            controller.necromancer = NpcNecromancer(
              properties.position,
              tileSize: Level0104Controller.tileSize,
              cameraCenterComponent: controller.cameraTarget,
              hintTextList: controller.hintTextList,
            );
            return controller.necromancer;
          },
          'archGate': (properties) {
            controller.archGate = ArchGateDecoration(
              tileSize: Level0104Controller.tileSize,
              initialPosition: properties.position,
            );
            return controller.archGate;
          },
          'buttonBlue': (properties) {
            controller.allButtons.add(properties.id!);
            return ButtonBlueDecoration(
              initPosition: properties.position,
              tileSize: Level0104Controller.tileSize,
              id: properties.id!,
              player: controller.player,
              callback: () {
                controller.activate(properties.id!);
                if (controller.allActivated()) controller.archGate.openGate();
              },
            );
          },
          'exitSensor': (properties) => ExitMapSensor(
                position: properties.position,
                size: properties.size,
                nextMap: controller.nextMap,
              ),
        },
      ),
      // プレイヤーキャラクター
      player: controller.player,
      onReady: (bonfireGame) async {
        await bonfireGame.add(controller.robo);
        await bonfireGame.add(controller.cameraTarget);
        bonfireGame.addJoystickObserver(controller.necromancer);
      },
      // カメラ設定
      cameraConfig: CameraConfig(
        // moveOnlyMapArea: true,
        sizeMovementWindow: Vector2.zero(),
        target: controller.cameraTarget,
        smoothCameraEnabled: true,
        smoothCameraSpeed: 10,
      ),
      // 入力インターフェースの設定
      joystick: controller.joystick,
      // ロード中の画面の設定
      progress: CodefireGameComponents.codefireProgress,
      focusNode: widget.focus,
    );
  }
}
