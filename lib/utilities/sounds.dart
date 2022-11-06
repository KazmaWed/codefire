import 'package:flame_audio/flame_audio.dart';

class Sounds {
  static const bgmFiles = [
    'bgm/main_title.mp3',
    'bgm/adventure_begins.mp3',
    'bgm/tragic_moment.mp3',
    'bgm/snowy_village.mp3',
    'bgm/first_dungeon.mp3',
    'bgm/first_boss.mp3',
    'bgm/ending.mp3',
    'bgm/common_enemy.mp3',
    'bgm/bizzare_character.mp3',
    'bgm/beach_village.mp3',
  ];
  static const seFiles = [
    'se/sfx_ui_cancel.mp3',
    'se/sfx_ui_confirm.mp3',
    'se/sfx_ui_equip.mp3',
    'se/sfx_ui_exit.mp3',
    'se/sfx_ui_menu_close.mp3',
    'se/sfx_ui_menu_open.mp3',
    'se/sfx_ui_menu_selections.mp3',
    'se/sfx_ui_pause.mp3',
    'se/sfx_ui_resume.mp3',
    'se/sfx_ui_saved.mp3',
    'se/sfx_ui_shop.mp3',
    'se/sfx_ui_unequip.mp3',
  ];

  static Future initialize() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll(bgmFiles);
    await FlameAudio.audioCache.loadAll(seFiles);
  }

  static void interaction() {
    FlameAudio.play('se/sfx_ui_menu_selections.mp3', volume: 1);
  }

  static stopBackgroundSound() {
    return FlameAudio.bgm.stop();
  }

  static void playBgmTitle() async {
    await FlameAudio.bgm.stop();
    FlameAudio.bgm.play('bgm/ending.mp3', volume: 0.15);
  }

  static void playBgmDungeon() async {
    await FlameAudio.bgm.stop();
    FlameAudio.bgm.play('bgm/adventure_begins.mp3', volume: 0.18);
  }

  static void buttonOn() async {
    FlameAudio.play('se/sfx_ui_confirm.mp3', volume: 1);
  }

  static void buttonOff() async {
    FlameAudio.play('se/sfx_ui_resume.mp3', volume: 1);
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
