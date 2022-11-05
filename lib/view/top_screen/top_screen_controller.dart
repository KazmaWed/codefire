import 'package:codefire/levels/level_01_01.dart';
import 'package:codefire/levels/level_01_02.dart';
import 'package:codefire/levels/level_01_03.dart';
import 'package:codefire/levels/level_01_04.dart';
import 'package:codefire/levels/level_02_01.dart';
import 'package:codefire/levels/level_02_02.dart';
import 'package:codefire/levels/level_02_03.dart';
import 'package:codefire/levels/level_02_04.dart';
import 'package:codefire/levels/level_03_01.dart';
import 'package:codefire/levels/level_03_02.dart';
import 'package:codefire/levels/level_03_03.dart';
import 'package:codefire/levels/level_03_04.dart';
import 'package:codefire/levels/level_09_01.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainScreenControllerProvider = StateProvider<MainScreenController>((ref) {
  return MainScreenController();
});

class MainScreenController {
  List<Map<String, dynamic>> levels = [
    {
      'name': 'レベル1',
      'description': 'CODEFIREの遊び方を知ろう',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': 'レベル2',
      'description': 'コードの書き方を知ろう',
      'maps': [
        {'map': const Level0201(), 'star': 0},
        {'map': const Level0202(), 'star': 0},
        {'map': const Level0203(), 'star': 0},
        {'map': const Level0204(), 'star': 0},
      ],
    },
    {
      'name': 'レベル3',
      'description': 'CODEFIREのルールを知ろう',
      'maps': [
        {'map': const Level0301(), 'star': 0},
        {'map': const Level0302(), 'star': 0},
        {'map': const Level0303(), 'star': 0},
        {'map': const Level0304(), 'star': 0},
      ],
    },
    {
      'name': 'レベル4',
      'description': '赤スイッチを避けよう',
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
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
        {'map': const Level0901(), 'star': 0}
      ],
    },
  ];
}
