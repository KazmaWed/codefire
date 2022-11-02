import 'package:codefire/decorations/arch_gate.dart';
import 'package:codefire/decorations/button_blue.dart';
import 'package:codefire/maps/dungeon_02/dungeon_02_controller.dart';
import 'package:codefire/npc/invisible_npc_for_camera.dart';
import 'package:codefire/npc/necromancer.dart';
import 'package:codefire/npc/necromancer_sprite.dart';
import 'package:codefire/npc/npc_robo_dino.dart';
import 'package:codefire/npc/npc_robo_dino_sprite.dart';
import 'package:codefire/player/player_bandit.dart';
import 'package:codefire/player/player_bandit_sprite.dart';
import 'package:codefire/view/common_component/codefire_components.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';

class Dungeon02 extends StatefulWidget {
  const Dungeon02({Key? key, required this.focus}) : super(key: key);
  final FocusNode focus;

  @override
  State<Dungeon02> createState() => _Dungeon02State();
}

class _Dungeon02State extends State<Dungeon02> {
  final controller = Dungeon02Controller();

  @override
  Widget build(BuildContext context) {
    final Set<int> allButtons = {};
    final cameraTarget = CameraTarget(
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
        'tiled/dungeon_02.json',
        forceTileSize: Vector2(Dungeon02Controller.tileSize, Dungeon02Controller.tileSize),
        objectsBuilder: {
          'necromancer': (properties) {
            controller.necromancer = NpcNecromancer(
              properties.position,
              tileSize: Dungeon02Controller.tileSize,
              cameraCenterComponent: cameraTarget,
            );
            return controller.necromancer;
          },
          'archGate': (properties) {
            controller.archGate = ArchGateDecoration(
              tileSize: Dungeon02Controller.tileSize,
              initialPosition: properties.position,
            );
            return controller.archGate;
          },
          'buttonBlue': (properties) {
            allButtons.add(properties.id!);
            return ButtonBlueDecoration(
              initPosition: properties.position,
              tileSize: Dungeon02Controller.tileSize,
              id: properties.id!,
              player: controller.player,
              callback: () {
                controller.activate(properties.id!);
                if (controller.allActivated()) controller.archGate.openGate();
              },
            );
          },
        },
      ),
      // プレイヤーキャラクター
      player: controller.player,
      onReady: (bonfireGame) async {
        await bonfireGame.add(controller.robo);
        await bonfireGame.add(cameraTarget);
      },
      // カメラ設定
      cameraConfig: CameraConfig(
        // moveOnlyMapArea: true,
        sizeMovementWindow: Vector2.zero(),
        target: cameraTarget,
        smoothCameraEnabled: true,
        smoothCameraSpeed: 10,
      ),
      // 入力インターフェースの設定
      joystick: codefireJoystick,
      // ロード中の画面の設定
      progress: codefireProgress,
      focusNode: widget.focus,
    );
  }
}
