import 'package:codefire/decorations/button_blue.dart';
import 'package:codefire/npc/npc_robo_dino.dart';
import 'package:codefire/npc/npc_robo_dino_sprite.dart';
import 'package:codefire/player/player_bandit.dart';
import 'package:codefire/player/player_bandit_sprite.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/services.dart';

class Dungeon01 extends StatefulWidget {
  const Dungeon01({Key? key, required this.commandInput}) : super(key: key);
  final ValueSetter<String> commandInput;
  @override
  State<Dungeon01> createState() => _Dungeon01State();
}

class _Dungeon01State extends State<Dungeon01> {
  static const tileSize = 48.0; // タイルのサイズ定義

  final player = PlayerBandit(
    Vector2(tileSize * 9, tileSize * 7),
    spriteSheet: PlayerBanditSprite.sheet,
    initDirection: Direction.up,
    tileSize: tileSize,
  );

  final robo = NpcRoboDino(
    Vector2(tileSize * 6, tileSize * 9),
    spriteSheet: NpcRoboDinoSprite.sheet,
    tileSize: tileSize,
  );

  @override
  Widget build(BuildContext context) {
    // 画面
    return BonfireWidget(
      // showCollisionArea: true,
      // マップ用jsonファイル読み込み
      map: WorldMapByTiled(
        'tiled/dungeon_01.json',
        forceTileSize: Vector2(tileSize, tileSize),
        objectsBuilder: {
          'button': (properties) => ButtonBlueDecoration(
                initPosition: properties.position,
                tileSize: tileSize,
                id: 0,
                player: player,
              ),
        },
      ),
      // プレイヤーキャラクター
      player: player,
      onReady: (bonfireGame) {
        bonfireGame.add(robo);
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
