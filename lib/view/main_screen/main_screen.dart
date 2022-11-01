import 'package:codefire/view/main_screen/main_screen_component.dart';
import 'package:codefire/view/main_screen/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:codefire/view/common_component/code_fire_scaffold.dart';

class CodefireMainScreen extends StatefulWidget {
  const CodefireMainScreen({super.key});

  @override
  State<CodefireMainScreen> createState() => _CodefireMainScreenState();
}

class _CodefireMainScreenState extends State<CodefireMainScreen> {
  final controller = MainScreenController();

  @override
  Widget build(BuildContext context) {
    return CodefireScaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(12),
            itemCount: controller.levels.length,
            itemBuilder: ((context, index) {
              final levelInfo = controller.levels[index];
              return CordfireLevelCard(
                name: levelInfo['name'],
                description: levelInfo['description'],
                map: levelInfo['map'],
              );
            }),
          ),
        ),
      ),
    );
  }
}
