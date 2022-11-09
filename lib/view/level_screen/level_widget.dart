import 'package:codefire/decorations/button_blue.dart';
import 'package:codefire/decorations/button_red.dart';
import 'package:codefire/view/level_screen/level_controller.dart';
import 'package:codefire/npc/invisible_npc_for_camera.dart';
import 'package:codefire/utilities/exit_map_sensor.dart';
import 'package:codefire/view/common_component/codefire_components.dart';
import 'package:codefire/view/top_screen/top_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LevelWidget extends ConsumerWidget {
  const LevelWidget({
    super.key,
    required this.levelController,
    required this.onClear,
  });
  final LevelController levelController;

  final Function onClear;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topScreenController = ref.watch(topScreenControllerProvider);

    final hintTextList = levelController.hintTextList == null
        ? null
        : levelController.hintTextList![topScreenController.language];

    levelController.cameraTarget = CameraTarget(
      player: levelController.player,
      components: [levelController.robo],
    );

    void onBlueButton(int id) {
      levelController.activate(id);
      if (levelController.allActivated()) {
        levelController.clearLevel();
        levelController.archGate.openGate();
        onClear();
      }
    }

    return Stack(
      children: [
        BonfireWidget(
          showCollisionArea: levelController.showCollisionArea,
          onTapUp: (game, screenPosition, worldPosition) {
            (game.player! as PlayerBandit).controller.moveToPoint(worldPosition);
          },
          // マップ用jsonファイル読み込み
          map: WorldMapByTiled(
            levelController.mapJsonPath,
            forceTileSize: Vector2.all(levelController.tileSize),
            objectsBuilder: {
              'necromancer': (properties) {
                levelController.necromancer = NpcNecromancer(
                  properties.position,
                  tileSize: levelController.tileSize,
                  cameraCenterComponent: levelController.cameraTarget,
                  hintTextList: hintTextList,
                );
                return levelController.necromancer;
              },
              'archGate': (properties) {
                levelController.archGate = ArchGateDecoration(
                  tileSize: levelController.tileSize,
                  initialPosition: properties.position,
                );
                return levelController.archGate;
              },
              'buttonBlue': (properties) {
                final newButton = ButtonBlueDecoration(
                  initPosition: properties.position,
                  tileSize: levelController.tileSize,
                  id: properties.id!,
                  player: levelController.player,
                  callback: () => onBlueButton(properties.id!),
                );
                levelController.addButton(newButton);
                return newButton;
              },
              'buttonRed': (properties) {
                return ButtonRedDecoration(
                  initPosition: properties.position,
                  tileSize: levelController.tileSize,
                  id: properties.id!,
                  player: levelController.player,
                  callback: () {
                    levelController.deactivateAll();
                  },
                );
              },
              'exitSensor': (properties) => ExitMapSensor(
                    position: properties.position,
                    size: properties.size,
                    nextMap: levelController.nextMap,
                  ),
            },
          ),
          // プレイヤーキャラクター
          player: levelController.player,
          onReady: (bonfireGame) async {
            await bonfireGame.add(levelController.robo);
            await bonfireGame.add(levelController.cameraTarget);
          },
          // カメラ設定
          cameraConfig: CameraConfig(
            // moveOnlyMapArea: true,
            sizeMovementWindow: Vector2.zero(),
            target: levelController.cameraTarget,
            smoothCameraEnabled: true,
            smoothCameraSpeed: levelController.tileSize / 10,
          ),
          // ロード中の画面の設定
          progress: CodefireGameComponents.codefireProgress,
          onDispose: () {
            levelController.player.controller.stopMoving();
          },
        ),
        Positioned(
          top: 32,
          left: 32,
          child: ObjectiveText(
            context: context,
            step: levelController.minimumStep,
            command: levelController.minimumCommand,
          ),
        ),
      ],
    );
  }
}
