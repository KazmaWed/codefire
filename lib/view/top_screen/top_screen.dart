import 'package:codefire/utilities/sounds.dart';
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
    final titleStyle = Theme.of(context).textTheme.titleLarge!;
    final bodyStyle = Theme.of(context).textTheme.bodyLarge!;
    final buttonStyle =
        Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).primaryColor);

    return Consumer(builder: ((context, ref, child) {
      final controller = ref.watch(mainScreenControllerProvider);

      // BGM
      if (controller.playBgm) {
        Sounds.playBgmTitle();
      } else {
        Sounds.stopBackgroundSound();
      }

      return CodefireScaffold(
        backgroundColor: Colors.white.withOpacity(0.94),
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(36),
                child: Column(children: [
                  Text('遊び方', style: titleStyle),
                  const SizedBox(height: 18),
                  Text(
                    '''
主人公は、画面をタップすると
タップした場所まで自動で歩きます。

ロボットはステージ内で書いたコードに従います。
詳しい動かし方はレベル1で教えてもらえるよ！
                    ''',
                    style: bodyStyle,
                  ),
                  const Spacer(),
                  Row(children: [
                    IconButton(
                      onPressed: () => controller.toggleBgmSetting(),
                      icon: Text('♫', style: buttonStyle),
                    ),
                  ])
                ]),
              ),
            ),
            Center(
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
            Expanded(child: Container()),
          ],
        ),
      );
    }));
  }
}
