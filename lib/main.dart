import 'package:bonfire/bonfire.dart';
import 'package:codefire/npc/npc_robo_dino_controller.dart';
import 'package:codefire/npc/npc_robo_dino_sprite.dart';
import 'package:codefire/player/player_bandit_sprite.dart';
import 'package:flutter/material.dart';
import 'package:codefire/view/main_screen/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PlayerBanditSprite.load();
  await NpcRoboDinoSprite.load();

  BonfireInjector().put((i) => NpcRoboDinoController());

  runApp(const MyApp());
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
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}
