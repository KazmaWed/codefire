import 'package:codefire/view/common_component/codefire_components.dart';
import 'package:codefire/view/top_screen/top_screen_component.dart';
import 'package:codefire/view/top_screen/top_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: ((context, ref, child) {
      final controller = ref.watch(mainScreenControllerProvider);

      return CodefireScaffold(
        backgroundColor: Colors.white.withOpacity(0.94),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 540),
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(18),
              itemCount: controller.levels.length,
              itemBuilder: ((context, index) {
                final Map<String, dynamic> levelInfo = controller.levels[index];
                return CordfireLevelCard(
                  context: context,
                  name: levelInfo['name'],
                  description: levelInfo['description'],
                  maps: levelInfo['maps'],
                );
              }),
            ),
          ),
        ),
      );
    }));
  }
}
