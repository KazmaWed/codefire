import 'package:codefire/maps/dungeon_01/dungeon_01_screen.dart';
import 'package:codefire/maps/dungeon_02/dungeon_02_screen.dart';
import 'package:codefire/maps/dungeon_03/dungeon_03_screen.dart';
import 'package:codefire/maps/level_01/level_01_01_screen.dart';

class MainScreenController {
  List<Map<String, dynamic>> levels = [
    {
      'name': 'LEVEL 1-1',
      'description': 'CODEFIREのルール1',
      'map': const Level0101Screen(),
    },
    {
      'name': 'TEST LEVEL 1',
      'description': 'Description.',
      'map': const Dungeon01Screen(),
    },
    {
      'name': 'TEST LEVEL 2',
      'description': 'Description.',
      'map': const Dungeon02Screen(),
    },
    {
      'name': 'TEST LEVEL 3',
      'description': 'Description.',
      'map': const Dungeon03Screen(),
    },
  ];
}
