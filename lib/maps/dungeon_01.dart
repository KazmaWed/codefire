import 'package:codefire/player/player_bandit.dart';
import 'package:codefire/player/player_bandit_sprite.dart';
import 'package:flutter/material.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/services.dart';

class Dungeon01 extends StatefulWidget {
  const Dungeon01({Key? key}) : super(key: key);
  @override
  State<Dungeon01> createState() => _Dungeon01State();
}

class _Dungeon01State extends State<Dungeon01> {
  final tileSize = 32.0; // タイルのサイズ定義

  @override
  Widget build(BuildContext context) {
    // 画面
    return BonfireWidget(
      // showCollisionArea: true,
      // マップ用jsonファイル読み込み
      map: WorldMapByTiled(
        'dungeon_01.json',
        forceTileSize: Vector2(tileSize, tileSize),
        objectsBuilder: {},
      ),
      // プレイヤーキャラクター
      player: PlayerBandit(
        Vector2(tileSize * 12, tileSize * 10),
        spriteSheet: PlayerBanditSprite.sheet,
        initDirection: Direction.up,
      ),
      // カメラ設定
      cameraConfig: CameraConfig(
        moveOnlyMapArea: true,
        sizeMovementWindow: Vector2.zero(),
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
