import 'package:codefire/decorations/button_blue.dart';
import 'package:codefire/maps/level_01/level_01_03_controller.dart';
import 'package:codefire/npc/invisible_npc_for_camera.dart';
import 'package:codefire/utilities/exit_map_sensor.dart';
import 'package:codefire/view/common_component/codefire_components.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';

class Level0103 extends StatefulWidget {
  const Level0103({Key? key, required this.focus}) : super(key: key);
  final FocusNode focus;
  @override
  State<Level0103> createState() => _Level0103State();
}

class _Level0103State extends State<Level0103> {
  final controller = Level0103Controller();
  @override
  Widget build(BuildContext context) {
    controller.cameraTarget = CameraTarget(
      player: controller.player,
      components: [controller.robo],
    );

    void onBlueButton(int id) {
      controller.activate(id);
      if (controller.allActivated()) {
        controller.robo.controller.succeed();
        controller.archGate.openGate();
      }
    }

    // 画面
    return BonfireWidget(
      showCollisionArea: controller.showCollisionArea,
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
          Level0103Controller.tileSize,
          Level0103Controller.tileSize,
        ),
        objectsBuilder: {
          'necromancer': (properties) {
            controller.necromancer = NpcNecromancer(
              properties.position,
              tileSize: Level0103Controller.tileSize,
              cameraCenterComponent: controller.cameraTarget,
              hintTextList: controller.hintTextList,
            );
            return controller.necromancer;
          },
          'archGate': (properties) {
            controller.archGate = ArchGateDecoration(
              tileSize: Level0103Controller.tileSize,
              initialPosition: properties.position,
            );
            return controller.archGate;
          },
          'buttonBlue': (properties) {
            controller.allButtons.add(properties.id!);
            return ButtonBlueDecoration(
              initPosition: properties.position,
              tileSize: Level0103Controller.tileSize,
              id: properties.id!,
              player: controller.player,
              callback: () => onBlueButton(properties.id!),
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
      onDispose: () {
        controller.player.controller.stopMoving();
      },
    );
  }
}
