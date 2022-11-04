import 'package:codefire/levels/level_01_01.dart';
import 'package:codefire/levels/level_01_02.dart';
import 'package:codefire/levels/level_01_03.dart';
import 'package:codefire/levels/level_01_04.dart';
import 'package:codefire/levels/level_04_01.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainScreenControllerProvider = StateProvider<MainScreenController>((ref) {
  return MainScreenController();
});

class MainScreenController {
  List<Map<String, dynamic>> levels = [
    {
      'name': 'レベル１',
      'description': 'CODEFIREの遊び方を覚えよう',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': 'レベル２',
      'description': 'コードの書き方を覚えよう',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': 'レベル３',
      'description': '最短ルートを見つけよう',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': 'レベル４',
      'description': '赤スイッチを避けよう',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': 'レベル５',
      'description': 'ループコマンドを使ってみよう その１',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': 'レベル６',
      'description': 'ループコマンドを使ってみよう その２',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': 'レベル７',
      'description': '分岐コマンドを使ってみよう その１',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': 'レベル８',
      'description': '分岐コマンドを使ってみよう その２',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': 'レベル９',
      'description': '難しいマップに挑戦しよう',
      'maps': [
        {'map': const Level0401(), 'star': 0}
      ],
    },
  ];
}
