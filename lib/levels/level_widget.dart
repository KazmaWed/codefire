import 'package:codefire/decorations/button_blue.dart';
import 'package:codefire/decorations/button_red.dart';
import 'package:codefire/levels/level_controller.dart';
import 'package:codefire/npc/invisible_npc_for_camera.dart';
import 'package:codefire/utilities/exit_map_sensor.dart';
import 'package:codefire/view/common_component/codefire_components.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';

class LevelWidget extends StatefulWidget {
  const LevelWidget({
    Key? key,
    required this.focus,
    required this.levelController,
    required this.onClear,
  }) : super(key: key);
  final FocusNode focus;
  final LevelController levelController;

  final Function onClear;
  @override
  State<LevelWidget> createState() => _Level0401State();
}

class _Level0401State extends State<LevelWidget> {
  @override
  Widget build(BuildContext context) {
    widget.levelController.cameraTarget = CameraTarget(
      player: widget.levelController.player,
      components: [widget.levelController.robo],
    );

    void onBlueButton(int id) {
      widget.levelController.activate(id);
      if (widget.levelController.allActivated()) {
        widget.levelController.clearLevel();
        widget.levelController.archGate.openGate();
        widget.onClear();
      }
    }

    // 画面
    return BonfireWidget(
      showCollisionArea: widget.levelController.showCollisionArea,
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
        widget.levelController.mapJsonPath,
        forceTileSize: Vector2.all(widget.levelController.tileSize),
        objectsBuilder: {
          'necromancer': (properties) {
            widget.levelController.necromancer = NpcNecromancer(
              properties.position,
              tileSize: widget.levelController.tileSize,
              cameraCenterComponent: widget.levelController.cameraTarget,
              hintTextList: widget.levelController.hintTextList,
            );
            return widget.levelController.necromancer;
          },
          'archGate': (properties) {
            widget.levelController.archGate = ArchGateDecoration(
              tileSize: widget.levelController.tileSize,
              initialPosition: properties.position,
            );
            return widget.levelController.archGate;
          },
          'buttonBlue': (properties) {
            final newButton = ButtonBlueDecoration(
              initPosition: properties.position,
              tileSize: widget.levelController.tileSize,
              id: properties.id!,
              player: widget.levelController.player,
              callback: () => onBlueButton(properties.id!),
            );
            widget.levelController.addButton(newButton);
            return newButton;
          },
          'buttonRed': (properties) {
            return ButtonRedDecoration(
              initPosition: properties.position,
              tileSize: widget.levelController.tileSize,
              id: properties.id!,
              player: widget.levelController.player,
              callback: () {
                widget.levelController.deactivateAll();
              },
            );
          },
          'exitSensor': (properties) => ExitMapSensor(
                position: properties.position,
                size: properties.size,
                nextMap: widget.levelController.nextMap,
              ),
        },
      ),
      // プレイヤーキャラクター
      player: widget.levelController.player,
      onReady: (bonfireGame) async {
        await bonfireGame.add(widget.levelController.robo);
        await bonfireGame.add(widget.levelController.cameraTarget);
        bonfireGame.addJoystickObserver(widget.levelController.necromancer);
      },
      // カメラ設定
      cameraConfig: CameraConfig(
        // moveOnlyMapArea: true,
        sizeMovementWindow: Vector2.zero(),
        target: widget.levelController.cameraTarget,
        smoothCameraEnabled: true,
        smoothCameraSpeed: 10,
      ),
      // 入力インターフェースの設定
      joystick: widget.levelController.joystick,
      // ロード中の画面の設定
      progress: CodefireGameComponents.codefireProgress,
      focusNode: widget.focus,
      onDispose: () {
        widget.levelController.player.controller.stopMoving();
      },
    );
  }
}
