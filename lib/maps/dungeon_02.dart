import 'package:codefire/decorations/arch_gate.dart';
import 'package:codefire/decorations/button_blue.dart';
import 'package:codefire/maps/dungeon_02_controller.dart';
import 'package:codefire/npc/npc_robo_dino.dart';
import 'package:codefire/npc/npc_robo_dino_sprite.dart';
import 'package:codefire/player/player_bandit.dart';
import 'package:codefire/player/player_bandit_sprite.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/services.dart';

class Dungeon02 extends StatefulWidget {
  const Dungeon02({Key? key}) : super(key: key);
  @override
  State<Dungeon02> createState() => _Dungeon02State();
}

class _Dungeon02State extends State<Dungeon02> {
  static const tileSize = 48.0; // タイルのサイズ定義

  final player = PlayerBandit(
    Vector2(tileSize * 10, tileSize * 12),
    spriteSheet: PlayerBanditSprite.sheet,
    initDirection: Direction.up,
    tileSize: tileSize,
  );

  final robo = NpcRoboDino(
    Vector2(tileSize * 8, tileSize * 12),
    spriteSheet: NpcRoboDinoSprite.sheet,
    tileSize: tileSize,
  );

  late final ArchGateDecoration archGate;

  late Dungeon02Controller controller;

  @override
  Widget build(BuildContext context) {
    final Set<int> allButtons = {};

    // 画面
    return BonfireWidget(
      showCollisionArea: true,
      // マップ用jsonファイル読み込み
      map: WorldMapByTiled(
        'tiled/dungeon_02.json',
        forceTileSize: Vector2(tileSize, tileSize),
        objectsBuilder: {
          'archGate': (properties) {
            archGate = ArchGateDecoration(
              tileSize: tileSize,
              initialPosition: properties.position,
            );
            return archGate;
          },
          'buttonBlue': (properties) {
            allButtons.add(properties.id!);
            return ButtonBlueDecoration(
              initPosition: properties.position,
              tileSize: tileSize,
              id: properties.id!,
              player: player,
              callback: () {
                controller.activate(properties.id!);
                if (controller.allActivated()) archGate.openGate();
              },
            );
          },
        },
      ),
      // プレイヤーキャラクター
      player: player,
      onReady: (bonfireGame) {
        bonfireGame.add(robo);
        controller = Dungeon02Controller(allButtons: allButtons);
      },
      // カメラ設定
      cameraConfig: CameraConfig(
        // moveOnlyMapArea: true,
        sizeMovementWindow: Vector2.zero(),
        target: player,
        smoothCameraEnabled: true,
        smoothCameraSpeed: 10,
      ),
      // 入力インターフェースの設定
      joystick: Joystick(
        // 画面上のジョイスティック追加
        directional: JoystickDirectional(
          color: Colors.white,
        ),
        actions: [
          // 画面上のアクションボタン追加
          JoystickAction(
            color: Colors.white,
            actionId: 1,
            margin: const EdgeInsets.all(65),
          ),
        ],
        // キーボード用入力の設定
        keyboardConfig: KeyboardConfig(
          keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows, // キーボードの矢印とWASDを有効化
          acceptedKeys: [LogicalKeyboardKey.space], // キーボードのスペースバーを有効化
        ),
      ),
      // ロード中の画面の設定
      progress: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.black,
      ),
    );
  }
}
