import 'package:codefire/levels/level_01_01.dart';
import 'package:codefire/levels/level_01_02.dart';
import 'package:codefire/levels/level_01_03.dart';
import 'package:codefire/levels/level_01_04.dart';
import 'package:codefire/levels/level_02_01.dart';
import 'package:codefire/levels/level_02_02.dart';
import 'package:codefire/levels/level_02_03.dart';
import 'package:codefire/levels/level_02_04.dart';
import 'package:codefire/levels/level_04_01.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainScreenControllerProvider = StateProvider<MainScreenController>((ref) {
  return MainScreenController();
});

class MainScreenController {
  List<Map<String, dynamic>> levels = [
    {
      'name': 'レベル1',
      'description': 'CODEFIREの遊び方を覚えよう',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': 'レベル2',
      'description': 'コードの書き方を覚えよう',
      'maps': [
        {'map': const Level0201(), 'star': 0},
        {'map': const Level0202(), 'star': 0},
        {'map': const Level0203(), 'star': 0},
        {'map': const Level0204(), 'star': 0},
      ],
    },
    {
      'name': 'レベル3',
      'description': '最短ルートを見つけよう',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': 'レベル4',
      'description': '赤スイッチを避けよう',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': 'レベル5',
      'description': 'ループコマンドを使ってみよう その１',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': 'レベル6',
      'description': 'ループコマンドを使ってみよう その２',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': 'レベル7',
      'description': '分岐コマンドを使ってみよう その１',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': 'レベル8',
      'description': '分岐コマンドを使ってみよう その２',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': 'レベル9',
      'description': '難しいマップに挑戦しよう',
      'maps': [
        {'map': const Level0401(), 'star': 0}
      ],
    },
  ];
}
