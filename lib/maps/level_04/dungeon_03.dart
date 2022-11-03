import 'package:codefire/decorations/arch_gate.dart';
import 'package:codefire/decorations/button_blue.dart';
import 'package:codefire/decorations/button_red.dart';
import 'package:codefire/maps/dungeon_02/dungeon_02_screen.dart';
import 'package:codefire/maps/level_04/dungeon_03_controller.dart';
import 'package:codefire/npc/invisible_npc_for_camera.dart';
import 'package:codefire/npc/necromancer.dart';
import 'package:codefire/npc/npc_robo_dino.dart';
import 'package:codefire/player/player_bandit.dart';
import 'package:codefire/utilities/exit_map_sensor.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';

class Dungeon03 extends StatefulWidget {
  const Dungeon03({Key? key, required this.focus}) : super(key: key);
  final FocusNode focus;

  @override
  State<Dungeon03> createState() => _Dungeon03State();
}

class _Dungeon03State extends State<Dungeon03> {
  static const jsonFilePath = 'tiled/dungeon_03.json';
  static final playerPosition = Vector2(13, 8.5);
  static final roboPosition = Vector2(11, 9);
  static const tileSize = 48.0; // タイルのサイズ定義

  late NpcNecromancer necromancer;

  final player = PlayerBandit(
    playerPosition * tileSize,
    initDirection: Direction.up,
    tileSize: tileSize,
  );

  final robo = NpcRoboDino(
    roboPosition * tileSize,
    tileSize: tileSize,
  );

  late final ArchGateDecoration archGate;

  late Dungeon03Controller controller;

  @override
  Widget build(BuildContext context) {
    final Set<int> allButtons = {};
    final Set<ButtonBlueDecoration> allButtonDecorations = {};
    final cameraTarget = CameraTarget(
      player: player,
      components: [robo],
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
        jsonFilePath,
        forceTileSize: Vector2(tileSize, tileSize),
        objectsBuilder: {
          'necromancer': (properties) {
            necromancer = NpcNecromancer(
              properties.position,
              tileSize: tileSize,
              cameraCenterComponent: cameraTarget,
            );
            return necromancer;
          },
          'archGate': (properties) {
            archGate = ArchGateDecoration(
              tileSize: tileSize,
              initialPosition: properties.position,
            );
            return archGate;
          },
          'buttonBlue': (properties) {
            allButtons.add(properties.id!);
            final newButton = ButtonBlueDecoration(
              initPosition: properties.position,
              tileSize: tileSize,
              id: properties.id!,
              player: player,
              callback: () {
                controller.activate(properties.id!);
                if (controller.allActivated()) archGate.openGate();
              },
            );
            allButtonDecorations.add(newButton);
            return newButton;
          },
          'buttonRed': (properties) {
            return ButtonRedDecoration(
              initPosition: properties.position,
              tileSize: tileSize,
              id: properties.id!,
              player: player,
              callback: () {
                controller.deactivateAll();
              },
            );
          },
          'exitSensor': (properties) => ExitMapSensor(
                position: properties.position,
                size: properties.size,
                nextMap: const Dungeon02Screen(),
              ),
        },
      ),
      // プレイヤーキャラクター
      player: player,
      onReady: (bonfireGame) async {
        await bonfireGame.add(robo);
        await bonfireGame.add(cameraTarget);
        controller = Dungeon03Controller(
          allButtons: allButtons,
          allButtonDecorations: allButtonDecorations,
        );
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
      joystick: Joystick(
        // キーボード用入力の設定
        keyboardConfig: KeyboardConfig(
          keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows, // キーボードの矢印とWASDを有効化
          // acceptedKeys: [LogicalKeyboardKey.space], // キーボードのスペースバーを有効化
        ),
      ),
      // ロード中の画面の設定
      progress: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.black,
      ),
      focusNode: widget.focus,
    );
  }
}
