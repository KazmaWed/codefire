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
  final List<Map<String, dynamic>> maps;

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 20,
          // color: Colors.white,
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                child: Text(description, style: descriptionStyle),
              ),
            ]),
            const SizedBox(height: 4),
            const Divider(height: 24),
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
          context.goTo(mapWidget);
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
