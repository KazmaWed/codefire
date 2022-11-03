import 'package:codefire/maps/dungeon_01/dungeon_01_screen.dart';
import 'package:codefire/maps/dungeon_02/dungeon_02_screen.dart';
import 'package:codefire/maps/dungeon_03/dungeon_03_screen.dart';
import 'package:codefire/maps/level_01/level_01_01_screen.dart';
import 'package:codefire/maps/level_01/level_01_02_screen.dart';
import 'package:codefire/maps/level_01/level_01_03_screen.dart';
import 'package:codefire/maps/level_01/level_01_04_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainScreenControllerProvider = StateProvider<MainScreenController>((ref) {
  return MainScreenController();
});

class MainScreenController {
  List<Map<String, dynamic>> levels = [
    {
      'name': 'LEVEL 1',
      'description': 'CODEFIREの遊び方を覚える',
      'maps': [
        {'map': const Level0101Screen(), 'star': 0},
        {'map': const Level0102Screen(), 'star': 0},
        {'map': const Level0103Screen(), 'star': 0},
        {'map': const Level0104Screen(), 'star': 0},
      ]
    },
    {
      'name': 'TEST LEVEL 1',
      'description': 'Description.',
      'maps': [
        {'map': const Dungeon01Screen(), 'star': 0}
      ],
    },
    {
      'name': 'TEST LEVEL 2',
      'description': 'Description.',
      'maps': [
        {'map': const Dungeon02Screen(), 'star': 0}
      ],
    },
    {
      'name': 'TEST LEVEL 3',
      'description': 'Description.',
      'maps': [
        {'map': const Dungeon03Screen(), 'star': 0}
      ],
    },
  ];
}
