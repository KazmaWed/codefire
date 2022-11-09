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
import 'package:codefire/levels/level_04_01.dart';
import 'package:codefire/levels/level_04_02.dart';
import 'package:codefire/levels/level_04_03.dart';
import 'package:codefire/levels/level_04_04.dart';
import 'package:codefire/levels/level_09_01.dart';
import 'package:codefire/levels/level_09_02.dart';
import 'package:codefire/levels/level_09_03.dart';
import 'package:codefire/levels/level_09_04.dart';
import 'package:codefire/utilities/languages.dart';
import 'package:codefire/utilities/sounds.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final topScreenControllerProvider = StateProvider<TopScreenController>((ref) {
  return TopScreenController();
});

class TopScreenController {
  Language _language = Language.japanese;
  bool _playBgm = false;
  // bool _playSe = false;

  bool get playBgm => _playBgm;
  Language get language => _language;
  // bool get playSe => _playSe;

  void changeLanguageSetting(Language to) {
    _language = to;
  }

  void toggleBgmSetting() {
    _playBgm = !_playBgm;
    if (_playBgm) {
      Sounds.playBgmTitle();
    } else {
      Sounds.pauseBackgroundSound();
    }
  }

  // void toggleSeSetting() {
  //   _playSe = !_playSe;
  // }

  String get gameDiscription =>
      _language == Language.japanese ? _gameDiscriptionJp : _gameDiscriptionEn;

  final String _gameDiscriptionJp = '''
恐竜型ロボット「ディノロボくん」をコードで操縦して、ステージ内のスイッチを全て押すとステージクリアです
コードの詳しい書き方はステージ内で教えてもらえます。

主人公は、画面をタップすると
タップした場所まで自動で歩きます

レベル5 - 8は未実装です。

レベル9はステージ1と3が問題、2と4はそれぞれの解答例です''';

  final String _gameDiscriptionEn = '''
Pilot Dino robot with codes to activate all buttons on a stage.
You will learn how to write codes in first stages.

To move the player charactor, click the destination on the screen.

Levels from 5 to 8 are still under development.
In Level 9, stage 1 & 3 are quizes and 2 & 4 are sample answers for each. 

English scripts are available only for level 1, 2 and 3.
''';

  final List<Map<dynamic, dynamic>> levels = [
    {
      'name': {
        Language.japanese: 'レベル1',
        Language.english: 'Level1',
      },
      'description': {
        Language.japanese: 'CODEFIREの遊び方を知ろう',
        Language.english: 'How to play CODEFIRE.',
      },
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': {
        Language.japanese: 'レベル2',
        Language.english: 'Level2',
      },
      'description': {
        Language.japanese: 'コードの書き方を知ろう',
        Language.english: 'How to write codes.',
      },
      'maps': [
        {'map': const Level0201(), 'star': 0},
        {'map': const Level0202(), 'star': 0},
        {'map': const Level0203(), 'star': 0},
        {'map': const Level0204(), 'star': 0},
      ],
    },
    {
      'name': {
        Language.japanese: 'レベル3',
        Language.english: 'Level3',
      },
      'description': {
        Language.japanese: 'CODEFIREのルールを知ろう',
        Language.english: 'Roles in CODEFIRE',
      },
      'maps': [
        {'map': const Level0301(), 'star': 0},
        {'map': const Level0302(), 'star': 0},
        {'map': const Level0303(), 'star': 0},
        {'map': const Level0304(), 'star': 0},
      ],
    },
    {
      'name': {
        Language.japanese: 'レベル4',
        Language.english: 'Level4',
      },
      'description': {
        Language.japanese: 'ループコマンドを使ってみよう',
        Language.english: 'Power of for loops. #1',
      },
      'maps': [
        {'map': const Level0401(), 'star': 0},
        {'map': const Level0402(), 'star': 0},
        {'map': const Level0403(), 'star': 0},
        {'map': const Level0404(), 'star': 0},
      ],
    },
    {
      'name': {
        Language.japanese: 'レベル5',
        Language.english: 'Level5',
      },
      'description': {
        Language.japanese: 'ループコマンドを使ってみよう 2',
        Language.english: 'Power of for loops. #2',
      },
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': {
        Language.japanese: 'レベル6',
        Language.english: 'Level6',
      },
      'description': {
        Language.japanese: 'if分岐を使ってみよう 1',
        Language.english: 'Power of for loops. #2',
      },
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': {
        Language.japanese: 'レベル7',
        Language.english: 'Level7',
      },
      'description': {
        Language.japanese: 'if分岐を使ってみよう 2',
        Language.english: 'Power of for loops. #2',
      },
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': {
        Language.japanese: 'レベル8',
        Language.english: 'Level8',
      },
      'description': {
        Language.japanese: '難しいステージに挑戦 1',
        Language.english: 'Difficult stages. #1',
      },
      'maps': [
        {'map': const Level0101(), 'star': 0},
        {'map': const Level0102(), 'star': 0},
        {'map': const Level0103(), 'star': 0},
        {'map': const Level0104(), 'star': 0},
      ],
    },
    {
      'name': {
        Language.japanese: 'レベル9',
        Language.english: 'Level9',
      },
      'description': {
        Language.japanese: '難しいステージに挑戦 2',
        Language.english: 'Difficult stages. #2',
      },
      'maps': [
        {'map': const Level0901(), 'star': 0},
        {'map': const Level0902(), 'star': 0},
        {'map': const Level0903(), 'star': 0},
        {'map': const Level0904(), 'star': 0},
      ],
    },
  ];
}
