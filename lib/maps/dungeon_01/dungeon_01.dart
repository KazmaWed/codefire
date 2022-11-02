import 'package:codefire/decorations/button_blue.dart';
import 'package:codefire/maps/dungeon_01/dungeon_01_controller.dart';
// import 'package:codefire/maps/dungeon_02_screen.dart';
import 'package:codefire/maps/dungeon_03/dungeon_03_screen.dart';
import 'package:codefire/npc/invisible_npc_for_camera.dart';
import 'package:codefire/utilities/exit_map_sensor.dart';
import 'package:codefire/view/common_component/codefire_components.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';

class Dungeon01 extends StatefulWidget {
  const Dungeon01({Key? key, required this.focus}) : super(key: key);
  final FocusNode focus;
  @override
  State<Dungeon01> createState() => _Dungeon01State();
}

class _Dungeon01State extends State<Dungeon01> {
  @override
  Widget build(BuildContext context) {
    final controller = Dungeon01Controller();
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
        'tiled/dungeon_01.json',
        forceTileSize: Vector2(
          Dungeon01Controller.tileSize,
          Dungeon01Controller.tileSize,
        ),
        objectsBuilder: {
          'necromancer': (properties) {
            controller.necromancer = NpcNecromancer(
              properties.position,
              tileSize: Dungeon01Controller.tileSize,
              cameraCenterComponent: controller.cameraTarget,
              hintTextList: controller.hintTextList,
            );
            return controller.necromancer;
          },
          'archGate': (properties) {
            controller.archGate = ArchGateDecoration(
              tileSize: Dungeon01Controller.tileSize,
              initialPosition: properties.position,
            );
            return controller.archGate;
          },
          'buttonBlue': (properties) {
            controller.allButtons.add(properties.id!);
            return ButtonBlueDecoration(
              initPosition: properties.position,
              tileSize: Dungeon01Controller.tileSize,
              id: properties.id!,
              player: controller.player,
              callback: () {
                controller.activate(properties.id!);
                if (controller.allActivated()) controller.archGate.openGate();
              },
            )..priority = -1;
          },
          'exitSensor': (properties) => ExitMapSensor(
                position: properties.position,
                size: properties.size,
                nextMap: const Dungeon03Screen(),
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
