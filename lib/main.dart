import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bonfire/bonfire.dart';
import 'package:codefire/npc/necromancer_sprite.dart';
import 'package:codefire/player/player_bandit_sprite.dart';
import 'package:codefire/player/player_bandit_controller.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/npc/npc_robo_dino_sprite.dart';
import 'package:codefire/view/main_screen/main_screen.dart';
// import 'package:codefire/maps/dungeon_01_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PlayerBanditSprite.load();
  await NpcRoboDinoSprite.load();
  await NpcNecromancerSprite.load();

  BonfireInjector().put((i) => NpcRoboDinoController());
  BonfireInjector().put((i) => PlayerBanditController());

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSansMono',
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const CodefireMainScreen(),
    );
  }
}
