import 'package:codefire/utilities/extentions.dart';
import 'package:codefire/view/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

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
  final List<Widget> maps;

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle =
        Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white);
    final TextStyle descriptionStyle =
        Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white);

    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.white12,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(children: [
              Text(name, style: titleStyle),
              const Spacer(),
              Text(description, style: descriptionStyle),
            ]),
            const SizedBox(height: 12),
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   children: [
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

  Widget levelButton(Widget map, int index) {
    final TextStyle style = Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white);
    final levelText = 'ステージ ${index + 1}';

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          child: Text(levelText, style: style),
        ),
        onTap: () {
          context.goTo(map);
        },
      ),
    );
  }
}

class GoBackFloatingButton extends StatelessWidget {
  const GoBackFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.close_rounded),
      onPressed: () {
        context.goTo(const CodefireMainScreen());
      },
    );
  }
}
