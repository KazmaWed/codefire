import 'package:flame_audio/flame_audio.dart';

class Sounds {
  static const aufioFiles = [
    'tragic_moment.mp3',
    'snowy_village.mp3',
    'main_title.mp3',
    'first_dungeon.mp3',
    'first_boss.mp3',
    'ending.mp3',
    'common_enemy.mp3',
    'bizzare_character.mp3',
    'beach_village.mp3',
    'adventure_begins.mp3',
  ];

  static Future initialize() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll(aufioFiles);
  }

  static void interaction() {
    FlameAudio.play('sound_interaction.wav', volume: 0.4);
  }

  static stopBackgroundSound() {
    return FlameAudio.bgm.stop();
  }

  static void playBackgroundSound() async {
    await FlameAudio.bgm.stop();
    FlameAudio.bgm.play('sound_bg.mp3');
  }

  static void playBackgroundBoosSound() {
    FlameAudio.bgm.play('battle_boss.mp3');
  }

  static void pauseBackgroundSound() {
    FlameAudio.bgm.pause();
  }

  static void resumeBackgroundSound() {
    FlameAudio.bgm.resume();
  }

  static void dispose() {
    FlameAudio.bgm.dispose();
  }
}
