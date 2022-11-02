import 'package:bonfire/joystick/joystick.dart';
import 'package:flutter/material.dart';

final codefireJoystick = Joystick(
  // // 画面上のジョイスティック追加
  // directional: JoystickDirectional(
  //   color: Colors.white,
  // ),
  // actions: [
  //   // 画面上のアクションボタン追加
  //   JoystickAction(
  //     color: Colors.white,
  //     actionId: 1,
  //     margin: const EdgeInsets.all(65),
  //   ),
  // ],
  // キーボード用入力の設定
  keyboardConfig: KeyboardConfig(
    keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows, // キーボードの矢印とWASDを有効化
    // acceptedKeys: [LogicalKeyboardKey.space], // キーボードのスペースバーを有効化
  ),
);

final codefireProgress = Container(
  width: double.maxFinite,
  height: double.maxFinite,
  color: Colors.transparent,
);
