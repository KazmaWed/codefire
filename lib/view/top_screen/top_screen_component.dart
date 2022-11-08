import 'package:codefire/utilities/extentions.dart';
import 'package:codefire/utilities/languages.dart';
import 'package:codefire/utilities/sounds.dart';
import 'package:codefire/view/top_screen/top_screen.dart';
import 'package:codefire/view/top_screen/top_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CordfireLevelCard extends StatelessWidget {
  const CordfireLevelCard({
    super.key,
    required this.context,
    required this.name,
    required this.description,
    required this.maps,
  });

  final BuildContext context;
  final String name;
  final String description;
  final List<Map<String, dynamic>> maps;

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 20,
        );
    final TextStyle descriptionStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Colors.white,
        );

    return Card(
      clipBehavior: Clip.antiAlias,
      // color: Colors,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(children: [
              Text(name, style: titleStyle),
              const Spacer(),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 6),
                child: Text(description, style: descriptionStyle),
              ),
            ]),
            const SizedBox(height: 4),
            const Divider(height: 24, thickness: 1),
            Wrap(
              runAlignment: WrapAlignment.start,
              spacing: 12,
              runSpacing: 8,
              children: [
                for (var index = 0; index < maps.length; index++) levelButton(maps[index], index),
              ],
            ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget levelButton(Map<String, dynamic> map, int index) {
    final TextStyle style = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Colors.black,
        );
    final levelText = 'ステージ${index + 1}';
    final Widget mapWidget = map['map'];
    final int mapStar = map['star'];

    const borderRadius = BorderRadius.all(Radius.circular(4));

    Widget starIndicator(int star) {
      final TextStyle starStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.orange,
            letterSpacing: 2.4,
          );
      return Text(
        '★' * star + '☆' * (3 - star),
        style: starStyle,
      );
    }

    return Consumer(builder: (context, ref, child) {
      return Card(
        child: InkWell(
          borderRadius: borderRadius,
          child: Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: borderRadius,
              border: Border.all(color: Colors.black12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Column(children: [
                Text(levelText, style: style),
                // const SizedBox(height: 4),
                starIndicator(mapStar),
              ]),
            ),
          ),
          onTap: () {
            final controller = ref.watch(topScreenControllerProvider);
            if (controller.playBgm) {
              Sounds.playBgmDungeon();
            } else {
              Sounds.stopBackgroundSound();
            }
            context.goTo(mapWidget);
          },
        ),
      );
    });
  }
}

class GoBackFloatingButton extends StatelessWidget {
  const GoBackFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.close_rounded),
      onPressed: () {
        context.goTo(const TopScreen());
      },
    );
  }
}

class LanguageToggle extends ConsumerWidget {
  const LanguageToggle({super.key, required this.callback});
  final Function callback;

  @override
  Widget build(context, ref) {
    final controller = ref.watch(topScreenControllerProvider);
    final TextStyle style = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Theme.of(context).primaryColor,
        );

    return Wrap(
      spacing: 8,
      children: [
        ChoiceChip(
          label: Text('日本語', style: style),
          selected: controller.language == Language.japanese,
          onSelected: (value) {
            controller.changeLanguageSetting(Language.japanese);
            // ref.read(topScreenControllerProvider.notifier).state = controller;
            callback();
          },
        ),
        ChoiceChip(
          label: Text('English', style: style),
          selected: controller.language == Language.english,
          onSelected: (value) {
            controller.changeLanguageSetting(Language.english);
            // ref.read(topScreenControllerProvider.notifier).state = controller;
            callback();
          },
        ),
      ],
    );
  }
}
